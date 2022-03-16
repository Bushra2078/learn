When you automate the publishing process for a template spec or a Bicep module, you need to ensure that everything you'd normally do on your own can be automated and run within the workflow. In this unit, you'll review how some of the principles you've previously learned about apply when you publish template specs and Bicep modules from a deployment workflow.

## Validate reusable code in a pipeline

Unlike regular Bicep deployments, when you create a template spec or a module, you don't deploy the resources directly to Azure. Instead, you provide the template spec or module to another deployment, which in turn will deploy them to Azure. This difference means that the ways you validate and test your template specs and Bicep modules might be different to regular Bicep files.

Linting your Bicep code is good practice. The linter detects syntactical problems, and also warns you if you're not following the recommended practices.

Beyond linting, you might want to consider testing your template specs and modules by using preflight deployments, or even deploying your template specs and modules to Azure and testing that the resources they create behave as you expect. However, it can be challenging to run these types of tests from a deployment workflow for two reasons:

- Preflight validation and deployments require an Azure environment to deploy the resources to. You might need to maintain a dedicated Azure subscription or resource group to use for deploying and testing your modules.
- Many template specs and modules require a set of parameters to be specified. You might need to create a test set of parameters for your template specs or modules to use when they're deployed.

You should choose whether to include workflow steps that deploy and test your template specs and modules. In this Microsoft Learn module, we lint the Bicep code but don't include other forms of testing. If you want to test your template specs and modules, consider how you'll deploy them to Azure, and whether you'll use dedicated subscriptions or resource groups to deploy the resources.

> [!TIP]
> We recommend you review [Test your Bicep code by using GitHub Actions](xref:learn.azure.test-bicep-code-using-github-actions) for more information on how to test your Bicep files in an automated pipeline.

## Authentication and authorization

When you publish template specs to Azure yourself, your Azure Active Directory user needs to be granted access to the resource group that contains the template spec resource. Likewise, when you publish a Bicep module to a registry, your Azure Active Directory user needs to have permission to write to the Azure Container Registry instance that your organization uses for their Bicep modules.

When you work with an automated deployment workflow, the same principles apply. However, because you aren't the person running the deployment, you need to ensure that your workflow's service principal is given the appropriate access to the resource group for publishing the template spec, or to the container registry for publishing modules.

> [!TIP]
> When you publish a module to a registry, the service principal running the deployment probably doesn't need a lot of permission. You could consider using the security *principle of least privilege*, and provide the workflow's service principal with access only to the container registry, and not to a resource group or subscription.

## Publish template specs and modules from a workflow

When you publish a template spec from your own computer by using the Azure CLI, you use this command:

```azurecli
az ts create \
  --name StorageWithoutSAS \
  --location westus \
  --display-name "Storage account with SAS disabled" \
  --description "This template spec creates a storage account, which is preconfigured to disable SAS authentication." \
  --version 1 \
  --template-file main.bicep
```

<!-- TODO mention versioning -->

You can convert this Azure CLI command to a GitHub Actions step:

```yaml
- name: Azure CLI script
  uses: azure/CLI@v1
  with:
    azcliversion: 2.30.0
    inlineScript: |
      az ts create \
        --name StorageWithoutSAS \
        --location westus \
        --display-name "Storage account with SAS disabled" \
        --description "This template spec creates a storage account, which is preconfigured to disable SAS authentication." \
        --version 1 \
        --template-file main.bicep
```

The workflow uses the same process to publish the template spec that you would use yourself.

Similarly, when you publish a Bicep module from your own computer by using the Azure CLI, you use this command:

```azurecli
az bicep publish \
   --file module.bicep \
   --target 'br:toycompany.azurecr.io/mymodules/modulename:moduleversion'
```

You can convert this Azure CLI command to a GitHub Actions step, too:

```yaml
- name: Azure CLI script
  uses: azure/CLI@v1
  with:
    azcliversion: 2.30.0
    inlineScript: |
      az bicep publish \
        --file module.bicep \
        --target 'br:toycompany.azurecr.io/mymodules/modulename:moduleversion'
```

<!-- TODO mention registry hostname and versioning -->

In the next set of exercise units, you'll see how you can publish a template spec from a workflow by using the steps described here.
