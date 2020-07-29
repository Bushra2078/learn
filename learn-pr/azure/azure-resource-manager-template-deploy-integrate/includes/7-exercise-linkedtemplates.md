> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're added to a special subscription named Concierge Subscription.

Here you will deploy linked and nested templates in the supplied sandbox environment.

This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## setup your test environment with the provided Azure sandbox subscription

To perform each deployment in this unit, you need to sign in to your Azure account from the Visual Studio Code terminal.

    :::image type="content" source="../media/vscode-terminal.gif" alt-text="Open the integrated terminal in Visual Studio Code." border="true":::

 Be sure you are signing in to the same account that activated the sandbox.

### Sign in to Azure

1. From the terminal in Visual Studio Code, run this command to sign in to Azure. Running this command will open a browser that allows you to sign in to your account.

    ```powershell
    Connect-AzAccount
    ```

1. Once you are logged in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox.
1. Get the subscription ID. The command will list your subscriptions and their IDs. The subscription ID is the second column. Look for Concierge Subscription and copy the second column. It will look something like cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0

    ```powershell
    Get-AzSubscription
    ```

1. Change your active subscription to the Concierge Subscription. Be sure to substitute {Your subscription ID} with the ID of the Concierge Subscription you just got in the last command.

    ```powershell
    $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $context
    ```

### Set the default resource group

1. You now need to set the resource group created for you in the sandbox as the default resource group.  do perform that operation you first need to get the resource group name by using the following command.

    ```powershell
    Get-AzResourceGroup
    ```

    and use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**) This allows you to omit that parameter from the rest of the Azure PowerShell commands in this exercise. 

    ```powershell
    Set-AzDefault -ResourceGroupName {Resource Group Name}
    ```

## Deploying a linked template

In this exercise, we will review and deploy a template that includes two linked templates.

1. To add a linked template to your ARM template, add a *Microsoft.Resources/deployments* resource and the *templateLink* property configured with the location of the template.

    In the sample template below, you will notice that there are 2 variable that define remote or external templates located on a github repo.

    - "linked-template": "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json"
    - "linked-template-2": "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"

    Please review the template and note the *"type": "Microsoft.Resources/deployments"* sections that define where and how the linked templates will be deployed.

    The fist linked template deploys a storage account.  it consumes the parent parameters and deploys the storage template.

    The second linked template is configured to depends on the storage deployment, and to deploys a virtual network template.

    ```json
        {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "name": {
                "type": "string",
                "defaultValue": "linkeddemo001"
            }
        },
        "variables": {
            "linked-template": "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json",
            "linked-template-2": "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
        },
        "resources": [
            {
                "name": "storage",
                "type": "Microsoft.Resources/deployments",
                "apiVersion": "2019-10-01",
                "properties": {
                    "mode": "Incremental",
                    "templateLink": {
                        "uri": "[variables('linked-template')]",
                        "contentVersion": "1.0.0.0"
                    },
                    "parameters": {
                         "location": {"value": "[resourceGroup().location]"}
                    }
                }
            },
            {
                "name": "identity",
                "type": "Microsoft.Resources/deployments",
                "apiVersion": "2019-10-01",
                "dependsOn": [
                    "[resourceId('Microsoft.Resources/deployments','storage')]"
                ],
                "properties": {
                    "mode": "Incremental",
                    "templateLink": {
                        "uri": "[variables('linked-template-2')]",
                        "contentVersion": "1.0.0.0"
                    }
                }
            }
        ],
        "outputs": {}
    }
    ```

1. To get started copy and paste the content of the template displayed above, into a file in a local directory.  **C:\JSON\linkedtemplate.json** for example.

    Once you have saved that file locally you can proceed to deploy it using the PowerShell command to deploy at the resource group level we talked about in the last unit. Namely, [New-AzResourceGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-azresourcegroupdeployment?view=azps-4.4.0&WT.mc_id=MSLearn-ARM-pierrer)

    ```powershell
        $templateFile="C:\JSON\linkedtemplate.json"
        $today=Get-Date -Format "MM-dd-yyyy"
        $DeploymentName="DeployLinkedTemplate-"+"$today"

        New-AzResourceGroupDeployment `
        -Name $DeploymentName `
        -TemplateFile $templateFile
    ```

    Once it completes you should have results like this:

    :::image type="content" source="../media/6-linked-template-results.png" alt-text="Results from deploying linked template." border="true":::

1. To validate the results in the Azure portal, navigate to [Azure](https://portal.azure.com?azure-portal=true) and make sure you are in the sandbox subscription. To do that, select your avatar in the upper right corner of the page. Choose **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

    1. On the left side panel, choose *Resource groups*.
    1. Select <rgn>[sandbox resource group name]</rgn>.
    1. In the *Overview*, you see the deployment has succeeded.
    1. Select *3 Succeeded* to see the details of the deployment. *(There may be more completed deployment depending on wether you performed the previous unit's exercises)*

        :::image type="content" source="../media/7-portal-deployment-details.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

    1. You will notice that you deployed one Template but 3 are listyed in the deployment pane of the portal. Those 3 deployments correspond to the Main templayte and the 2 linked templates.

        :::image type="content" source="../media/7-portal-deployment-listing.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::

