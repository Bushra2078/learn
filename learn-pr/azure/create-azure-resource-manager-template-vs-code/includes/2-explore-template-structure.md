Here, you learn about using Microsoft Azure Resource Manager templates to implement infrastructure as code. You survey the sections of an Azure Resource Manager template, discover how to deploy your template to Azure, and delve into detail on the *resources* section of the template.

## What is infrastructure as code

*Infrastructure as code* enables you to describe, through code, the infrastructure that you need for your application.

With infrastructure as code, you can maintain both your application code and everything you need to deploy your application in a central code repository. The advantages to infrastructure as code are:

- Consistent configurations
- Improved scalability
- Faster deployments
- Better traceability

> [!VIDEO https://channel9.msdn.com/Blogs/One-Dev-Minute/What-is-Infrastructure-as-Code--One-Dev-Question/player?format=ny]

## What is an Azure Resource Manager template

Azure Resource Manager (ARM) templates are JavaScript Object Notation (JSON) files that define the infrastructure and configuration for your deployment. The template uses a *declarative syntax*. The declarative syntax is a way of building the structure and elements that outline what resources will look like without describing its control flow. Declarative syntax is different than *imperative syntax*, which uses commands for the computer to perform. Imperative scripting focuses on specifying each step in deploying the resources.

ARM templates allow you declare what you intend to deploy without having to write the sequence of programming commands to create it.  In a template, you specify the resources and the properties for those resources, then the [Azure Resource Manager](https://docs.microsoft.com/azure/azure-resource-manager/management/overview?azure-portal=true) uses that information to deploy the resources in an organized and consistent manner.

### Benefits of using Azure Resource Manager templates

Using ARM templates allows you to automate deployments and use the practice of infrastructure as code (IaC). The template code becomes part of your infrastructure and development projects. Just like application code, you can store the IaC files in a source repository and version it.

Templates are *idempotent*, which means you can deploy the same template many times and get the same resource types in the same state.

The Azure Resource Manager orchestrates the deployment of the resources so they're created in the correct order, and when possible, in parallel, so your deployments finish faster than scripted deployments.

  :::image type="content" source="../media/2-template-processing.png" alt-text="A mapping of the template processing procedure showing that there is only once call to process a template as opposed to several calls to process scripts." border="true":::

Azure Resource Manager also has built in validation and checks the template before starting the deployment to make sure the deployment will succeed.

If your deployments become more complex, you can break your templates into smaller, reusable components and link them together at deployment time. You can also nest one or multiple templates inside other templates.

In the Azure portal, you can review your deployment history and get information about the state of the deployment. You can see all the parameter values passed in, and any output values.

You can also integrate your templates into continuous integration and continuous deployment (CI/CD) tools like [Azure Pipelines](https://azure.microsoft.com/services/devops/pipelines?azure-portal=true), which can automate your release pipelines for fast and reliable application and infrastructure updates. By using Azure DevOps and ARM template tasks, you can continuously build and deploy your projects.

### Template file structure

When writing an ARM template, you need to understand all the parts that make up the template and what they do. The template files are made up of the following elements.

- *schema* - a required section that defines the location of the JSON schema file that describes the structure of JSON data. The version number you use depends on the scope of the deployment and your JSON editor.

- *contentVersion* - a required section that defines the version of your template (such as 1.0.0.0). You can use this value to document significant changes in your template to ensure you're deploying the right template.

- *apiProfile* - an optional section that defines a collection of API versions for resource types.  You can use this value to avoid having to specify API versions for each resource in the template.

- *parameters* -  an optional section where you define values that will be provided when the deployment is executed. These values can be provided by a parameter file, by command-line parameters or in the portal.

- *variables* - an optional section where you define values that are used to simplify template language expressions.

- *functions* - an optional section where you can define [User-defined functions](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-user-defined-functions?azure-portal=true) that are available within the template. You can create your own functions when you have complicated expressions that are used repeatedly in your template.

- *resources* - a required section that defines the actual items you want to deploy, or that you want to update, in a resource group or a subscription.

- *output* section - an optional section where you specify the values that will be returned at the end of the deployment.

## How do I deploy a template to Azure

There are three ways to deploy an ARM template to Azure.

- Deploy a local template
- Deploy a linked template
- Deploy in a continuous deployment pipeline

Deploying a local template requires you to have either [Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.2.0&azure-portal=true) or [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true) installed locally. You first sign in to Azure using Azure CLI or Azure PowerShell.

# [Azure CLI](#tab/azure-cli)

```azurecli
az login
```

# [PowerShell](#tab/azure-powershell)

```azurepowershell
Connect-AzAccount
```

---

Then, you create a resource group or use an already defined resource group to deploy into. If you need to create a resource group, you can use this command:

# [Azure CLI](#tab/azure-cli)

```azurecli
az group create \
  --name {name of your resource group} \
  --location "{location}"
```

# [PowerShell](#tab/azure-powershell)

```azurepowershell
New-AzResourceGroup `
  -Name {name of your resource group} `
  -Location "{location}"
```

---

To deploy the template, use either the Azure CLI command [az deployment group create](https://docs.microsoft.com/cli/azure/group/deployment?view=azure-cli-latest#az-group-deployment-create?azure-portal=true) or the Azure PowerShell command [New-AzResourceGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-azresourcegroupdeployment?view=azps-4.2.0&azure-portal=true). Specify the resource group and give a name to the deployment so you can easily identify it in the deployment history. For convenience, create a variable that stores the path to the template file. This variable makes it easier for you to run the deployment commands because you don't have to retype the path every time you deploy. Here is an example:

# [Azure CLI](#tab/azure-cli)

To run this deployment command, you must have the [latest version](/cli/azure/install-azure-cli) of Azure CLI.

```azurecli
templateFile="{provide-the-path-to-the-template-file}"
az deployment group create \
  --name blanktemplate \
  --resource-group myResourceGroup \
  --template-file $templateFile
```

# [PowerShell](#tab/azure-powershell)

```azurepowershell
$templateFile = "{provide-the-path-to-the-template-file}"
New-AzResourceGroupDeployment `
  -Name blanktemplate `
  -ResourceGroupName myResourceGroup `
  -TemplateFile $templateFile
```

---

Linked templates are used to deploy complex solutions. You can break a template into many templates, and deploy these templates through a main template. When the main template gets deployed, it triggers the deployment of the linked template. You can store and secure the linked template by using a SAS token.

A continuous integration/continuous deployment (CI/CD) pipeline automates building and deploying development project including Azure Resource Manager template projects. The two most common pipelines used for template deployment are [Azure Pipelines](https://docs.microsoft.com/learn/paths/deploy-applications-with-azure-devops/?azure-portal=true) or [GitHub Actions](https://docs.microsoft.com/learn/paths/automate-workflow-github-actions/?azure-portal=true).

More information on these two types of deployment are covered in other modules.

## How do I add resources to the template

To add a resource to your template, you will need to know the resource provider and its types of resources. The syntax for this combination is in the form of *{resource-provider}/{resource-type}*. For example, to add a storage account resource to your template, you will need the *Microsoft.Storage* resource provider. One of the types for this provider is *storageAccount*. So your resource type will be displayed as *Microsoft.Storage/storageAccounts*. You can use a list of [Resource providers for Azure services](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-services-resource-providers?azure-portal=true) to find the providers you need.

Once you have the provider and resource type, you need to know the properties to use for that resource type. For that, you can go to the [Define resources in Azure Resource Manager template](https://docs.microsoft.com/azure/templates?azure-portal=true) page. There you will see a left side menu to find the resource you are looking for. Notice that the properties are sorted by API version.

![Microsoft documentation page showing the storage account documentation selected.](../media/2-resource-type-properties.png)

Here is an example of some of the listed properties from the Storage Accounts page:

![Microsoft documentation page showing some of the storage account properties.](../media/2-storage-account-properties.png)

For our storage example, your template might look like this:

```json
{
   "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
   "contentVersion": "1.0.0.1",
   "apiProfile": "",
   "parameters": {},
   "variables": {},
   "functions": [],
   "resources": [
       {
           "type": "Microsoft.Storage/storageAccounts",
           "apiVersion": "2019-06-01",
           "name": "learntemplatestorage123",
           "location": "westus",
           "sku": {
               "name": "Standard_LRS"
           },
           "kind": "StorageV2",
           "properties": {
               "supportsHttpsTrafficOnly": true
           }
       }
   ],
   "outputs": {}
}
```
