Now that you've used a deployment script to migrate some manual work into your ARM template, another partner application team in your organization asks for some help.

Their process has similar requirements, but they need to deploy multiple files to their storage account. They have a PowerShell script that can take a list of files as a parameter upload them, similar to the script you were already using in your template.

In this exercise, you'll take your previous template as a starting point and update the PowerShell script to use the one from your partner team. Then you will add a way to enable the person who's deploying the template to specify what configuration files to deploy (one or more).

This exercise uses [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Create the starting template

You start with the template you created in the last exercise.

1. Open Visual Studio Code, and create a new file called *azuredeploy.json*.
1. Copy the starting template below into *azuredeploy.json*.

    :::code language="json" source="code/template-with-deploymentscript.json" :::

1. Save the template.

## Update the PowerShell script

Since the other team has done the hard work in creating a PowerShell script to copy multiple files, you decide to use their script in your template.

Edit the `scriptContent` in the `properties` section to include the script provided by your partner team.

:::code language="powershell" source="code/template-with-deploymentscript-parameters.json" range="121-134" :::

## Add an environment variable

The script you've adopted requires some environment variables. You can specify them directly in the template, but it will be more flexible to use template functions to get some of the values.

1. Add an `environmentVariables` property to the `properties` of the deployment script.

    :::code language="powershell" source="code/template-with-deploymentscript-parameters.json" range="105,118" :::

1. Add environment variable for `ResourceGroupName`

    :::code language="powershell" source="code/template-with-deploymentscript-parameters.json" range="105-108,117-118" highlight="2-5" :::

1. Add environment variable for `StorageAccountName`

    :::code language="powershell" source="code/template-with-deploymentscript-parameters.json" range="105-112,117-118" highlight="6-9":::

1. Add environment variable for `StorageContainerName`

    :::code language="powershell" source="code/template-with-deploymentscript-parameters.json" range="105-118" highlight="10-13":::

> [!TIP]
> Use [template functions](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions-resource) to access common values like `[resourceGroup().name]` and `[variables()]`.

## Add a template parameter

To make your template easier to use by the two teams, you can add a parameter to the template so that each team can specify the files they want to copy.

1. Add a parameter to the template to take an array of file names.

    :::code language="json" source="code/template-with-deploymentscript-parameters.json" range="5-7,9-13" :::

1. For bonus points, supply a default value so the template will continue to work for your team with no changes to their deployment process.

## Add an argument to pass in the files to copy

Next, you can take the parameter you just defined and pass it in to the deployment script. Passing command line arguments can be tricky, because there are multiple levels where the strings are evaluated. Properly escaping quotes and picking the right quotes for the job are essential for success.

> [!TIP]
> Use [template functions](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions-resource) to access common functions like `[string()]` to convert values of one type to a string.

1. Add an `arguments` property to the deployment script.  The PowerShell script takes a parameter named `File`, which is a string of file names that should come from the `filesToCopy` template parameter. Make sure there are quotes around the whole argument so it gets passed in properly.

    > [!CAUTION]
    > This `arguments` property is invalid. If you are using the Azure Resource Manager extension in VS Code, it may flag this line. You will fix this problem in the next steps.

    ```json
    "arguments": "[concat( '-File '', string(parameters('filesToCopy')), ''' )]",
    ```

    > [!TIP]
    > Quoting things in JSON can be hard, especially when passing in command line arguments. You can use a template variable to represent a character that's hard to escape.

1. Add a template variable to represent the single quote character.

    :::code language="json" source="code/template-with-deploymentscript-parameters.json" range="14-21" highlight="2" :::

1. Replace the single quotes in the `arguments` property with the variable you just defined.

    :::code language="json" source="code/template-with-deploymentscript-parameters.json" range="104" :::

## Update the template output

Since you are changing the deployment script to deploy one or more files, you need to update the template output to provide all the necessary information.

1. Update the `outputs` in the template to return the whole object, which will have a URI per file.

    :::code language="json" source="code/template-with-deploymentscript-parameters.json" range="141-150" highlight="3-4" :::

1. Add an additional output with the storage account name (which has a random identifier). You will use this later to validate the deployment script did what you expect.

    :::code language="json" source="code/template-with-deploymentscript-parameters.json" range="141-150" highlight="6-9" :::

## Verify your template

Your template should look similar to:

:::code language="json" source="code/template-with-deploymentscript-parameters.json" :::

If it does not, either copy the example or adjust your template to match the example.

### Create a parameters file

Now that you've got our template set, you can validate our new deployment script by using a parameters file with new files specified.

1. Either create an *azuredeploy.parameters.json* file manually or use [the VS Code extension](https://docs.microsoft.com/azure/azure-resource-manager/templates/quickstart-create-templates-use-visual-studio-code?tabs=CLI#create-a-parameter-file) to do so.
1. Edit the file to have two files specified:

    ```json
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "filesToCopy": {
                "value": [
                    "swagger.Staging.json",
                    "appsettings.Staging.json"
                ]
            }
        }
    }
    ```

## Deploy the template

::: zone pivot="cli"

### Create a resource group for the exercise

You need to create a resource group to contain the resources you will create as part of this exercise. By using a new resource group, cleaning up after the exercise will be much easier.

From the terminal in Visual Studio Code, run this command to create the resource group for this exercise.

```azurecli
resourceGroupName="learndeploymentscript_exercise_2"
az group create --location eastus --name $resourceGroupName
```

### Deploy the template to Azure

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
templateFile="azuredeploy.json"
templateParameterFile="azuredeploy.parameters.json"
today=$(date +"%d-%b-%Y")
deploymentName="deploymentscript-"$today

az deployment group create \
    --resource-group $resourceGroupName \
    --name $deploymentName \
    --template-file $templateFile
    --parameters $templateParameterFile
```

### Review the result of your template

Once the deployment is complete, you can validate both files were copied to your storage account by listing the contents of the blob container.

1. List the contents of the blob container.

    ```azurecli
    storageAccountName=$(az deployment group show --resource-group $resourceGroupName --name $deploymentName --query 'properties.outputs.storageAccountName.value' --output tsv)
    az storage blob list --account-name $storageAccountName --container-name config
    ```

    You should see the following returned from the above command.

    ```azurecli
    [
      "swagger.Staging.json",
      "appsettings.Staging.json"
    ]
    ```

1. You can also review the logs (and other details about the deployment) from the Azure portal or with the following command line.

    ```azurecli
    az deployment-scripts show-log --resource-group $resourceGroupName --name CopyConfigScript
    ```

### Clean up the resource group

You've successfully deployed an ARM template with a deployment script and used different methods to pass data in to customize its behavior. You can remove the resource group that contains all the resources and role assignments you've created.

```azurecli
az group delete --name $resourceGroupName
```

::: zone-end

::: zone pivot="powershell"

### Create a resource group for the exercise

You need to create a resource group to contain the resources you will create as part of this exercise. By using a new resource group, cleaning up after the exercise will be much easier.

From the terminal in Visual Studio Code, run this command to create the resource group for this exercise.

```azurepowershell
$ResourceGroupName="learndeploymentscript_exercise_2"
New-AzResourceGroup -Location eastus -Name $ResourceGroupName
```

### Deploy the template to Azure

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$TemplateFile = "azuredeploy.json"
$TemplateParameterFile = "azuredeploy.parameters.json"
$Today=Get-Date -Format "MM-dd-yyyy"
$DeploymentName="deploymentscript-"+"$Today"
New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -Name $DeploymentName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParameterFile
```

### Review the result of your template

Once the deployment is complete, you can validate both files were copied to your storage account by listing the contents of the blob container.

1. List the contents of the blob container.

    ```azurepowershell
    $StorageAccountName = (Get-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -Name $DeploymentName).Outputs.storageAccountName.Value
    $StorageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName
    Get-AzStorageAccountBlob -Context $StorageAccount.Context -Container config |
        Select-Object Name
    ```

    You should see the following returned from the above command.

    ```azurepowershell
    Name
    ----
    swagger.Staging.json
    appsettings.Staging.json
    ```

1. You can also review the logs (and other details about the deployment) from the Azure portal or with the following command line.

    ```azurepowershell
    Get-AzDeploymentScriptLog -ResourceGroupName $ResourceGroupName -Name CopyConfigScript
    ```

### Clean up the resource group

You've successfully deployed an ARM template with a deployment script and used different methods to pass data in to customize its behavior. You can remove the resource group that contains all the resources and role assignments you've created.

```azurepowershell
Remove-AzResourceGroup -Name $ResourceGroupName
```

::: zone-end
