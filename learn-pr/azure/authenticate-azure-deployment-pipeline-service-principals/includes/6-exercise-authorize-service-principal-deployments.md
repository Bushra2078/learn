In the previous exercise, you created a service principal, and tested you could log in using its key. This will be the service principal you use for your website's deployment pipeline. Now you're ready to grant the service principal access to your Azure environment. In this exercise, you'll create a role assignment for the service principal, and then deploy a Bicep file by using the service principal.

During the process, you'll:

> [!div class="checklist"]
> * Sign in as your own user account.
> * Create a resource group for your company's website.
> * Create a role assignment to allow the service principal to deploy resources to the resource group.
> * Sign in as the service principal and deploy the Bicep file that creates your company's website resources.
> * Verify the deployment.
> * Clean up the resource group and service principal.

## Sign in as your user account

In the previous exercise, you logged in using the service principal and then you logged out. You need to log in as your own user account again so that you can follow along with the next steps in this exercise.

::: zone-pivot="cli"

1. In the Visual Studio Code terminal, sign in to Azure by running the following command: 

    ```azurecli
    az login
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone-pivot="powershell"

1. In the Visual Studio Code terminal, sign in to Azure by running the following command:

    ```azurepowershell
    Connect-AzAccount
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a resource group

Now you will create a resource group to contain the toy company's website resources.

::: zone pivot="cli"

1. Run this Azure CLI command in the Visual Studio Code terminal to create a resource group:

   ```azurecli
   az group create --name ToyWebsite --location eastus
   ```

1. Look at the JSON output from the previous command. It includes a property named `id`, which is the resource group's ID. Copy this somewhere safe. You'll use it soon.

::: zone-end

::: zone pivot="powershell"

1. Run this Azure PowerShell command in the Visual Studio Code terminal to create a resource group:

   ```azurepowershell
   New-AzResourceGroup -Name ToyWebsite -Location eastus
   ```

1. Look at the output from the previous command. It includes a property named `ResourceId`, which is the resource group's ID. Copy this somewhere safe. You'll use it soon.

::: zone-end

## Create a role assignment

For your website's deployment pipeline, you decide to create a role assignment with the following details:

- **Assignee:** The service principal you created in the previous exercise.
- **Role:** The **Contributor** built-in role.
- **Scope:** The resource group created in the previous step.

::: zone pivot="cli"

Run this Azure CLI command in the Visual Studio Code terminal to create the role assignment. Make sure you replace the placeholders with the values you copied earlier:

```azurecli
az role assignment create \
  --assignee SERVICE-PRINCIPAL-APPLICATION-ID \
  --role Contributor \
  --scope YOUR-RESOURCE-GROUP-ID \
  --assignee-principal-type ServicePrincipal \
  --description "The deployment pipeline for the company's website needs to be able to create resources within the resource group."
```

::: zone-end

::: zone pivot="powershell"

Run this Azure CLI command in the Visual Studio Code terminal to create the role assignment. Make sure you replace the placeholders with the values you copied earlier:

```azurepowershell
New-AzRoleAssignment `
  -ApplicationId SERVICE-PRINCIPAL-APPLICATION-ID `
  -RoleDefinitionName Contributor `
  -Scope YOUR-RESOURCE-GROUP-ID `
  -ObjectType ServicePrincipal `
  -Description 'The deployment pipeline for the company's website needs to be able to create resources within the resource group.'
```

::: zone-end

## Create a Bicep file

You previously created a Bicep file that deploys your website's resources. Here, you save this so that you can test it by using the service principal.

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Add the following content to the *main.bicep* file. You'll deploy the template soon. It's a good idea to type it in manually instead of copying and pasting, so that you can see how the tooling helps you to write your Bicep files.

   :::code language="bicep" source="code/6-template.bicep" :::

1. Save the changes to the file.

## Deploy the Bicep file using the service principal

You don't currently have a deployment pipeline, so we'll simulate what a pipeline does to deploy your Bicep file. First, you'll sign in using the service principal's credentials. Next, you'll deploy the Bicep file you just created.

::: zone pivot="cli"

1. Run this Azure CLI command in the Visual Studio Code terminal to log in using the service principal's credentials. Make sure you replace the placeholders with the values you copied in the previous exercise.

   ```azurecli
   az login --service-principal \
     --username SERVICE-PRINCIPAL-NAME \
     --password SERVICE-PRINCIPAL-PASSWORD \
     --tenant YOUR-AZURE-AD-TENANT-ID
   ```

1. Deploy the Bicep file by running the following Azure CLI command:

   ```azurecli
   az deployment group create \
     --resource-group ToyWebsite \
     --template-file main.bicep
   ```

   The deployment might take a minute or two to finish, and then you'll see a successful deployment.

::: zone-end

::: zone pivot="powershell"

1. Run this Azure PowerShell command in the Visual Studio Code terminal to securely prompt you for the service principal's credentials. Use the service principal's name and key from the previous exercise for the username and password, respectively.

   ```azurepowershell
   $credential = Get-Credential
   ```

1. Run this Azure PowerShell command in the Visual Studio Code terminal to log in using the service principal's credentials. Make sure you replace the placeholders with the values you copied in the previous step.

   ```azurepowershell
   Connect-AzAccount -ServicePrincipal `
     -Credential $credential `
     -Tenant YOUR-AZURE-AD-TENANT-ID
   ```

1. Deploy the Bicep file by running the following Azure PowerShell command:

   ```azurepowershell
   New-AzResourceGroupDeployment -ResourceGroupName ToyWebsite -TemplateFile main.bicep
   ```

   The deployment might take a minute or two to finish, and then you'll see a successful deployment.

::: zone-end

## Verify the deployment

Use the Azure portal to inspect the resources that you deploy and to inspect the results of the deployment.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left pane, select **Resource groups**.

1. Select **ToyWebsite**.

1. In the **Overview** section, you can see that one deployment has succeeded.
 
    :::image type="content" source="../media/6-deployment.png" alt-text="Screenshot of the Azure portal resource group overview pane, with a section displaying a successful deployment." border="true":::

1. Next to **Deployments**, select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/6-deployment-succeeded.png" alt-text="Screenshot of the Azure portal resource group overview pane, displaying additional details of the successful deployment." border="true":::

1. Select the deployment called **main** to see what resources were deployed, and then select **Deployment details** to expand it. 
 
   In this case, the App Service plan and app, as well as the Application Insights instance, are listed.

    :::image type="content" source="../media/6-development-deployment-details.png" alt-text="Screenshot of the Azure portal resource group overview pane for the specific deployment, with an App Service plan and app, and an Application Insights instance listed." border="true":::

## Clean up the resource group and service principal

You've successfully created a service principal and role assignment, and deployed your website's resources by using a Bicep file. You can now remove the resources that you've created.

::: zone pivot="cli"

1. Run the following Azure CLI command to delete the resource group, its contents, and the role assignment:

   ```azurecli
   az group delete --name ToyWebsite --no-wait
   ```

   When you're prompted to confirm, enter `y`. Notice that you use the `--no-wait` argument to run the deletion asynchronously in the background.

1. Run the following command to delete the service principal. Make sure you replace the `SERVICE-PRINCIPAL-NAME` placeholder with the application ID you copied in the previous exercise:

   ```azurecli
   az ad sp delete --id SERVICE-PRINCIPAL-NAME
   ```

::: zone-end

::: zone pivot="powershell"

1. Run the following Azure PowerShell command to delete the resource group, its contents, and the role assignment:

   ```azurepowershell
   Remove-AzResourceGroup -Name ToyWebsite -AsJob
   ```

   When you're prompted to confirm, enter `y`. Notice that you use the `-AsJob` argument to run the deletion asynchronously in the background.

1. Run the following command to delete the service principal. Make sure you replace the `SERVICE-PRINCIPAL-NAME` placeholder with the application ID you copied in the previous exercise:

   ```azurepowershell
   Remove-AzADServicePrincipal -ApplicationId SERVICE-PRINCIPAL-NAME
   ```

::: zone-end