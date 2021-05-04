There are many tool sets available for infrastructure as code resource deployments. You want to learn more about when Bicep is the right tool for you and your organization.

## Is Bicep the right tool?

There are many reasons to choose Bicep as the main tool set for your infrastructure as code deployments. For Azure deployments, Bicep has some advantages, but Bicep doesn't work as a language for other cloud providers.

### When is Bicep the right tool?

If you're using Azure as your cloud platform, consider these advantages of using Bicep.

- **Azure-native** - With Bicep, you're using a language that is native to Azure. When new Azure resources are released or updated, Bicep will support those features on day one. When using other third-party tools, it may take some time before the new features are defined in the tool set.

- **Azure integration** - ARM templates, both JSON and Bicep, are fully integrated within the Azure platform. With ARM-base deployments, you can monitor the progress of the deployment in the Azure portal.

- **Azure support** - Bicep is a fully supported product with Microsoft Support.

- **No State management** - Bicep deployments compare the current state of your Azure resources with the state you define in the template. You don't need to keep your resource state information somewhere else, such as in a storage account. Azure keeps track of this state for you automatically.

- **Easy transition from JSON** - If you're already using ARM JSON templates as your declarative template language, it isn't a difficult process to transition over to Bicep. The Bicep CLI can de-compile any ARM template into a Bicep template, by using the `bicep decompile` command.

### When is Bicep not the right tool?

Some situations may call for another tool set. Consider the following reasons to not use Bicep as your main tool set.

- **Existing tool set** - When determining when to use Bicep, the first question to ask is, "does your company have a tool set already in use?". There are many tooling options available that can be used for infrastructure as code-based resource provisioning. Sometimes, it makes sense to use existing financial and knowledge investments when adopting a new process.

- **Multi-cloud** - If your organization uses multiple cloud providers to host its infrastructure, Bicep may not be the right tool. Other cloud providers don't support Bicep as a template language. Open-source tools, such as Terraform, can be used for multi-cloud deployments, including deployments to Azure.
