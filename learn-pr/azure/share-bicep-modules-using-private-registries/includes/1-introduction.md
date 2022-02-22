Bicep modules enable you create composable, reusable files that define a set of related resources. You then use those modules in your deployment templates. When you work with Bicep code in your own organization, you often create reusable modules that your colleagues would benefit from. These modules might create resources in a way that fits your organization's requirements, such as by using your defined naming conventions and configuring resources so that they meet your security requirements. Private Bicep registries provide an easy way for you to share these modules within your organization.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've previously worked with one of your toy product development teams to create a set of Bicep modules. You created a module to deploy a website, and another module to deploy a content delivery network (CDN).

Now, another team has come to you to ask to reuse the same modules for their own deployments. They're building a new toy dog, and they need to deploy a website and CDN to help promote the product on social media.

You considered sending the modules to each team by email, but you're worried about how you'll control access and manage different versions. You want to find a way to share the modules throughout your organization, to make it easier for any team to reuse them for future deployments.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram showing the C D N and website modules being published to a registry and used by multiple other deployments." border="false":::

## What will we be doing?

In this module, you'll learn about private registries for sharing modules. You'll find out how create your own private registry, and how you publish modules to it. You'll also learn about how to consume modules from a private registry.

## What is the main goal?

By the end of this module, you'll be able to create private registries, publish modules to them, and consume modules from them.

## Prerequisites

You should be familiar with using:

- Bicep, including how to use modules, parameters, and how to deploy Bicep files to Azure.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.

To work through the exercises, you'll also need the following installed locally:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true).
- The latest [Azure CLI](/cli/azure/install-azure-cli) tools *or* the latest [Azure PowerShell](/powershell/azure/install-az-ps).
