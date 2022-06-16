You've been requested by Fabrikam to deploy a Microsoft Purview account to their Azure environment to create a proof of concept. In this unit, we'll cover configuration settings, account concepts, and key considerations for deployment.

## Microsoft Purview account name

The Microsoft Purview account name is used to programmatically access the Microsoft Purview account and can't be changed. The name of your Microsoft Purview account must follow these rules:

* Globally unique - no other account can have this name
* Can contain only letters, numbers and hyphens
* The first and last characters must be a letter or number
* Spaces aren't allowed

:::image type="content" source="../media/purview-account-name.png" alt-text="Microsoft Purview account name":::

But don't worry if the name you want isn't available. Your Microsoft Purview account can also have a friendly name that can include spaces and doesn't need to be globally unique. The friendly name can be added after the account is created, and will be the name displayed inside the Microsoft Purview governance portal, while the original account name will still be used to access the account programmatically.

## Managed resources

Microsoft Purview creates a storage account and an Azure Event Hubs account as managed resources within the subscription that the Microsoft Purview account is provisioned in. These resources are required to support enhanced security features during scanning.

* The name of the managed resource group will be auto-generated but can be changed during the Microsoft Purview account creation process.
* The names of the storage account and Azure Event Hubs namespace will be auto-generated during account creation and can't be changed.

:::image type="content" source="../media/purview-managed-resources.png" alt-text="Microsoft Purview managed resources":::

## Microsoft Purview Data Map

Microsoft Purview Data Map provides the foundation for data governance and discovery in Microsoft Purview. The data map captures and organizes metadata from your data landscape so you can know what kind of data you’re storing and where.

The data map is automatically kept up to date with built-in scanning and classification, and it provides an interface that business users and developers can configure together to make a useable environment to discover and manage data.

The data map powers all of Microsoft Purview’s other applications by housing the information, and providing access control.

:::image type="content" source="../media/purview-data-map.png" alt-text="Microsoft Purview data map":::

Inside the data map you'll find **collections**, which serve two functions:

- Data organization - collections organize sources (like SQL or storage accounts) and their assets (like tables and files) into customized groups that reflect your business.
- Access control - groups and users are assigned to roles in collections that allow you to manage who has access to your resources and assets.

We'll discuss collections more deeply in the upcoming sections.

Since the data map stored all your metadata, and provides the compute power to ingest this data, size of the Data Map is measured in Capacity Units, which are compute and storage units. There's no need to predetermine the number of Capacity Units required as Microsoft Purview will **auto-scale** up and down based on usage.

## Capacity Units

All Microsoft Purview accounts come with one Capacity Unit by default, and elastically grow based on usage. The Data Map is **always on** while the Microsoft Purview account exists, in which case, there will always be a minimum of 1 Capacity Unit consumed.

Each Capacity Unit:

* Can support up to **25 data map operations per second**.
* Includes storage of up to **10 GB** of metadata about data assets.

## Scanning

Scanning is a core action that Microsoft Purview uses to populate its Data Map. After your Microsoft Purview account is created, resources are registered, and then they're **scanned**. During scanning, Microsoft Purview gathers metadata about the data assets inside your storage source. For example, the number of files or the kind of data that's stored.

The compute required for this automated population of the Data Map is serverless (**pay as you go**), run on logical compute units called vCores. Duration of these jobs can vary based on the number of systems scanned, data assets (files or tables, for example) in the scanned systems, number of data classifications you want to identify, the shape of the data, and performance of the system scanned. Scanning is billed based on the number of vCore Hours consumed, which is the number of compute units needed to process the data, and the amount of time those units were needed.

## Network connectivity

You can connect to your Microsoft Purview account either publicly, via public IP addresses or service endpoints, or privately, using a private endpoint. In this module, our proof of concept will use a publicly available Microsoft Purview account, since we're creating a simple proof of concept. But you can also [learn more about private endpoints for your Microsoft Purview account](/azure/purview/catalog-private-link).

:::image type="content" source="../media/purview-networking.png" alt-text="Microsoft Purview networking":::
