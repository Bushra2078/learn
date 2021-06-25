By now, you're used to deploying ARM templates to Azure using Bicep or JSON. You create a template file, and then you submit it to Azure by creating a deployment. Azure Resource Manager orchestrates the creation or reconfiguration of your resources. When you work with template specs, you still send the template to Azure, but instead of deploying it, Azure will save it for you to use in the future. Then, you can go back later and tell Azure to deploy the template spec, and you can even use the same template spec repeatedly to deploy lots of environments.

## Why use template specs?

At your toy company, you have created lots of reusable templates, including:

| Template name | Description |
|-|-|
| Storage account |  Deploys a storage account and enforces Azure AD authentication. |
| Cosmos DB account | Deploys a Cosmos DB account with continuous backup enabled. |
| Virtual network | Deploys a virtual network that has the right configuration to peer with the main hub network. |
| Product launch website | Deploys an App Service plan, app, and storage account for new toy product launch websites. |

Template specs are a great way to create a library of reusable ARM templates for common scenarios in your organization. An expert can build a template with a preconfigured resource or set of resources, and then publish it as a template spec, enabling other people in the organization can deploy it. You can use template specs to ensure the resources your team creates are configured according to your requirements. For example, you could publish the storage account template described above as a template spec. Whenever anyone in your organization deploys your template spec, you can be sure they've created a storage account with the right authentication settings.

Template specs are stored within Azure itself, so you don't need to maintain shared template files yourself, and you can use Azure's built-in role-based access control to manage who can use and modify the template specs. Without template specs, you need to choose a storage location, like Azure Storage, to keep your template files. You also need to control access yourself.

::: zone pivot="biceppowershell,bicepcli"

### How do template specs compare to Bicep modules?

When you work with Bicep, you can create reusable _modules_ to define sets of resources in a single file. Template specs and Bicep modules are both ways of adding reusability to your templates, but they are optimized for different things:

* Template specs are stored in Azure as a resource. You need to store Bicep modules somewhere that you control, like a version control system such as Git, or your file system.
* Bicep modules are intended to be combined into a larger deployment. Template specs are designed to be deployable as a complete template, although you can use a template spec within a deployment if you want.
* Template specs provide versioning and access control capabilities. You need to manage the versions and security for your Bicep code yourself.
* Bicep modules retain all of the original Bicep code, including comments, symbolic names, and whitespace. When you create a template spec using Bicep, your Bicep code is converted to JSON and some of this information is lost, so you need to keep the source Bicep file somewhere else as well.

When you're deciding between template specs and Bicep modules, a good rule of thumb is: if the template is going to be deployed as-is throughout your organization, template specs are probably a good fit. But if you are likely to reuse this template within multiple parent templates, Bicep modules might serve your needs better.

::: zone-end

## How template specs work

A template spec is an Azure resource, just like a storage account or virtual machine. It must be created within a resource group, although the template itself can deploy resources to a subscription, management, or tenant scope.

When you work with template specs, you create two resources:

* The **template spec** is the container resource. It contains one or multiple versions.
* **Template spec versions** contain the actual template to deploy.

You work with template specs and versions by using their resource IDs. Here's an example template spec resource ID:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/SharedTemplates/providers/Microsoft.Resources/templateSpecs/StorageWithoutSAS
```

A version is a child resource of the template spec, and it has a resource ID like this:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/SharedTemplates/providers/Microsoft.Resources/templateSpecs/StorageWithoutSAS/versions/1.0
```

When you deploy a template spec, you need to specify the resource ID of the template spec version.

Here's an illustration of the workflow you'll follow when you use template specs:

:::image type="content" source="../media/2-workflow.png" alt-text="Diagram showing the workflow for using template specs." border="false":::

:::image type="icon" source="../media/callout-01.png"::: You create a template like you are used to. There's nothing special about a template that you create for a template spec - you declare resources, create parameters and variables, use functions, and so forth.

:::image type="icon" source="../media/callout-02.png"::: When your template is ready, you create a template spec resource, and you publish your template to the template spec as a version. The tooling you use to create template specs enables you to do this all in one operation. Once you've published your template spec, it's stored in Azure as a resource, and you can view it, edit it, and control access to it just like any other Azure resource. You can publish your template spec from your local machine or from a deployment pipeline.

:::image type="icon" source="../media/callout-03.png":::  Whenever you want to deploy your template spec, you refer to the template spec version's resource ID from the deployment. You can deploy it to any resource group, or even to another subscription or scope. Azure reads the template spec and uses that as the template for the deployment.
