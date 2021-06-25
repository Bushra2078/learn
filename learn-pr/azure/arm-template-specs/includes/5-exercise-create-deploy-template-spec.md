[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

At your toy company, your team has worked with Azure for a while now, and you've created lots of templates that you use on a daily basis. You decide to take one template and create a template spec, and you decide to start with the template you use to create Cosmos DB accounts. Your team has decided that continuous backup needs to be configured on all of your Cosmos DB accounts, so you want to include this in the default configuration of Cosmos DB accounts that are provisioned using the template spec.

In this exercise, you publish the Cosmos DB template as a template spec.

During the process, you'll:

> [!div class="checklist"]
> * Create a template that you'll use as the template spec.
> * Update the template to ensure the parameters are easy to understand and work with.
> * Publish the template spec.
> * Verify the template spec using the Azure portal.
> * Deploy the template spec to test it.
> * Verify the deployment.

::: zone pivot="bicepcli,biceppowershell"

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

::: zone-end

## Create the template

You start with one of the templates that your team has already created. The template deploys a Cosmos DB account, and configures it to enable continuous backup on the Cosmos DB account.

::: zone pivot="bicepcli,biceppowershell"

1. Open Visual Studio Code.

2. Create a new file called *main.bicep*.

3. Save the empty file so that Visual Studio Code loads the Bicep tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

4. Copy the following code into *main.bicep*.

   :::code language="bicep" source="code/5-starting.bicep" :::

   Notice that you set the `backupPolicy` to `Continuous`. This configures Cosmos DB to take backups of your data on a continuous basis instead of periodically.

5. Save the file.

::: zone-end

::: zone pivot="jsoncli,jsonpowershell"

1. Open Visual Studio Code.

1. Create a new file called *azuredeploy.json*.

1. Save the empty file so that Visual Studio Code loads the ARM template tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Copy the following code into *azuredeploy.json*.

   :::code language="json" source="code/5-starting.json" :::

   Notice that you set the `backupPolicy` to `Continuous`. This configures Cosmos DB to take backups of your data on a continuous basis instead of periodically.

1. Save the file.

::: zone-end

## Make the parameters easier to understand

When you work with template specs, it's important you consider how others will use your template. This is especially important for parameters, since they're the main way other people will interact with your code. The parameters in your team's template don't include descriptions or other hints about how they should be use, so here you add this information in.

::: zone pivot="bicepcli,biceppowershell"

1. Update the `location` parameter definition to add a description:

   :::code language="plaintext" source="code/5-template.bicep" range="1-2" highlight="1" :::

1. Update the `cosmosDBAccountName` parameter definition to add a description, and to specify the minimum and maximum length of the name:

   :::code language="plaintext" source="code/5-template.bicep" range="4-7" highlight="1-3" :::

1. Save the file.

::: zone-end

::: zone pivot="jsoncli,jsonpowershell"

1. Update the `location` parameter definition to add a description:

   :::code language="json" source="code/5-template.json" range="5-11" highlight="4-6" :::

1. Update the `cosmosDBAccountName` parameter definition to add a description, and to specify the minimum and maximum length of the name:

   :::code language="json" source="code/5-template.json" range="12-20" highlight="4-8" :::

1. Save the file.

::: zone-end

## Sign into Azure

::: zone pivot="bicepcli"

[!include[Bootstrapping instructions for first Bicep exercise - CLI](../../includes/azure-template-bicep-exercise-sandbox-deploy-cli.md)]

::: zone-end

::: zone pivot="biceppowershell"

[!include[Bootstrapping instructions for first Bicep exercise - PowerShell](../../includes/azure-template-bicep-exercise-sandbox-deploy-powershell.md)]

::: zone-end

::: zone pivot="jsoncli"

[!include[Bootstrapping instructions for first JSON exercise - CLI](../../includes/azure-template-json-exercise-sandbox-deploy-cli.md)]

::: zone-end

::: zone pivot="jsonpowershell"

[!include[Bootstrapping instructions for first JSON exercise - PowerShell](../../includes/azure-template-json-exercise-sandbox-deploy-powershell.md)]

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

## Convert the Bicep file to a JSON ARM template

Template specs don't yet support Bicep files directly. You need to convert your Bicep file to a JSON template before you publish it, using this command:

::: zone-end

::: zone pivot="bicepcli"

```azurecli
az bicep build --file main.bicep --outfile azuredeploy.json
```

::: zone-end

::: zone pivot="biceppowershell"

```powershell
bicep build main.bicep --outfile azuredeploy.json
```

::: zone-end

## Publish the template as a template spec

::: zone pivot="biceppowershell,jsonpowershell"

Publish the template spec by using this Azure PowerShell cmdlet in the Visual Studio Code terminal:

:::code language="azurepowershell" source="code/5-create.ps1" range="1-8" :::

::: zone-end

::: zone pivot="bicepcli,jsoncli"

Publish the template spec by using this Azure CLI command in the Visual Studio Code terminal:

:::code language="azurecli" source="code/5-create.sh" range="1-7" :::

::: zone-end

## Use the Azure portal to verify the template spec

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page. 
   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left-side panel, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**. Notice that the template spec is included in the list of resources:

   :::image type="content" source="../media/5-resource-group-template-spec.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the template spec included in the list of resources." border="true":::

1. Select **ToyCosmosDBAccount** to open the template spec. Notice you can see the versions and the template file.

   :::image type="content" source="../media/5-template-spec.png" alt-text="Screenshot of the Azure portal interface for the template spec." border="true":::

## Deploy the template spec

For simplicity, you'll deploy the template spec into the same sandbox resource group that the template spec itself is stored in. Normally, you keep template specs in a different resource group. However, the steps are the same both ways.

::: zone pivot="biceppowershell,jsonpowershell"

1. Get the template spec version's resource ID by executing the following Azure PowerShell command:

   ```azurepowershell
   $templateSpecVersionResourceId = (`
      Get-AzTemplateSpec `
         -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
         -Name ToyCosmosDBAccount `
         -Version 1.0 `
      ).Versions[0].Id
   ```

   Notice that you use the `Versions` property. When you deploy a template spec, you need to reference the resource ID of the specific version of the template spec to use.

1. Deploy the template spec by using this Azure PowerShell command in the Visual Studio Code terminal:

   ```azurepowershell
   New-AzResourceGroupDeployment -TemplateSpecId $templateSpecVersionResourceId
   ```

::: zone-end

::: zone pivot="bicepcli,jsoncli"

1. Get the template spec version's resource ID by executing the following Azure CLI command:

   ```azurecli
   templateSpecVersionResourceId=$(az ts show \
     --name ToyCosmosDBAccount --version 1.0 --query id --output tsv)
   ```

1. Deploy the template spec by using this Azure CLI command in the Visual Studio Code terminal:

   ```azurecli
   az deployment group create --template-spec $templateSpecVersionResourceId
   ```

::: zone-end

This can take a minute or two to complete, and then you'll see a successful deployment.

## Verify your deployment

1. In your browser, go back to the Azure portal. Go to your resource group.

1. Next to **Deployments**, select **1 Succeeded** to see the details of the deployment.

   :::image type="content" source="../media/5-deployment-succeeded.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that one succeeded." border="true":::

1. Select the deployment.

   :::image type="content" source="../media/5-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the one deployment listed." border="true":::

   Your deployment's name might look different to ours.

1. Select **Deployment details** to expand it. Notice that a Cosmos DB account has been deployed.

   :::image type="content" source="../media/5-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with three Cosmos DB resources listed." border="true":::
