Once an Azure Cosmos DB for NoSQL account is ready to go through a release lifecycle, it's not uncommon for an operations team to attempt to automate the creation of Azure Cosmos DB resources in the cloud. Automation makes it easier to deploy new environments, restore past environments, or scale a service out.

In Azure, Azure Resource Manager and Bicep templates are two of the ways you can automate the creation of Azure Cosmos DB resources. Azure Resource Manager templates are JavaScript Object Notation (JSON) files that define the infrastructure and configuration for your project. Bicep is an alternative template language that can be used to develop templates.

> [!NOTE]
> For this module, we will use both the **Bicep** and **JSON** syntaxes for **Azure Resource Manager templates**. The hands-on exercise for this module will use both the **Bicep** and **JSON** syntaxes to illustrate the differences.

After completing this module, you'll be able to:

- Identify the three most common resource types for Azure Cosmos DB for NoSQL accounts
- Create and deploy a JSON Azure Resource Manager template for an Azure Cosmos DB for NoSQL account, database, or container
- Create and deploy a Bicep template for an Azure Cosmos DB for NoSQL account, database, or container
- Manage throughput and index policies using JSON or Bicep templates
