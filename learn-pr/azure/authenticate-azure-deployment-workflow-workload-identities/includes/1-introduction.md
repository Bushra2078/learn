Deployment workflows need to communicate with Azure so that they can create and configure your Azure resources. In this module, you'll learn how workload identities work, how to create and manage them, and how to authorize them to work with Azure on your behalf.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've created a Bicep file to deploy your company's website. Until now, you've been deploying it from your own computer by using command-line tools. You've decided to move the deployment into a GitHub Actions workflow. 

One of your colleagues has told you that you need to set up a service principal for the deployment workflow. You need to understand what this is, and then set it up so you can deploy your company's website.

## What will we be doing?

In this module, you'll create a workload identity, ready for your workflow to use. You'll create a resource group in Azure to contain your company's website, and you'll authorize the service principal to deploy and configure your website's resources.

> [!NOTE]
> The information in this Microsoft Learn module is specific to GitHub Actions deployment workflows. If you use Azure Pipelines, the way your pipelines authenticate is different. To learn more about Azure Pipelines and deployment authorization, see [Authenticate your Azure deployment pipeline by using service principals](xref:learn.azure.authenticate-azure-deployment-pipeline-service-principals).

## What is the main goal?

By the end of this module, you'll have an understanding of workload identities and how they relate to other Azure and Azure Active Directory (Azure AD) security concepts. You'll be able to create an Azure AD application registration and manage its federated credentials. You'll also be able to determine the best authorization policy to use for your workflow's identity, and configure the appropriate role assignments in Azure.

## Prerequisites

You should be familiar with:

- Creating and deploying basic Bicep files, including modules.
- Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.
- Basic GitHub Actions workflows.

To follow along with the exercises in the module, you'll need:

- An Azure account, with the ability to create resource groups and to create Azure AD applications and service principals.
  > [!TIP]
  > If you can't meet these requirements with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant.
- [Visual Studio Code](https://code.visualstudio.com), installed locally.  
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), installed locally.  
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools, installed locally.  
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps), installed locally.
