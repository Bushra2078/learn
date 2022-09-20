Azure Cosmos DB is a multi-model, globally distributed, NoSQL based database service. It stores data as containers of schemaless documents. Azure Cosmos DB enables you to distribute data globally, scale performance horizontally, and apply varying levels of consistency according to your organization's requirements. 

You can create and manage Azure Cosmos DB using a variety of tools:

* Visual Studio Code
* Azure portal from a web browser
* CLIs such as Azure CLI & PowerShell


In this unit, you'll learn more about how Azure Cosmos DB organizes data. You'll see how to use Visual Studio Code to create and maintain Azure Cosmos DB and containers.

## What is Azure Cosmos DB?

Azure Cosmos DB is a cloud service that implements document databases. The data in a document must conform to JSON syntax. A JSON document can contain properties, subdocuments, and arrays of documents. The following example shows a JSON document that stores product information, as part of a retail application. The **tags** property is an example of a subdocument:

```JSON
{
    "id": "08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2",
    "categoryId": "75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C",
    "categoryName": "Bikes, Touring Bikes",
    "sku": "BK-T79U-50",
    "name": "Touring-1000 Blue, 50",
    "description": "The product called \"Touring-1000 Blue, 50\"",
    "price": 2384.0700000000002,
    "tags": [
        {
            "_id": "27B7F8D5-1009-45B8-88F5-41008A0F0393",
            "name": "Tag-61"
        }
    ]
}
```

Unlike a table in a relational database, documents in a Azure Cosmos DB don't follow a pre-defined schema. This allows the database to hold a variety of documents with different *shapes* and sizes. For example, you could store varying information about different customers in the same database. Perhaps you could record a complete address history as an array for a customer. You might record additional information, such as their credit worthiness.

> [!NOTE]
> Azure Cosmos DB adds some fields of its own to your documents. Many of these fields are used for internal purposes, and in most cases you shouldn't modify them directly. The exception is a field named **id**. Azure Cosmos DB uses this field to identify the document in the database, and each document must have a unique **id**. Azure Cosmos DB will generate a value for the **id** field automatically, but you can specify your value for each document if you prefer. Specifying your values is useful if you are bringing your existing data to Cosmos DB or a specific id datatype for tracking documents and connecting with other data.

Azure Cosmos DB provides REST API and SDKs that let you create, update, delete, and query documents.

The Azure Cosmos DB cloud service is organized as a hierarchy. At the top is a Azure Cosmos DB account (your resource). The Azure Cosmos DB account is the unit of security for a set of databases. The Azure Cosmos DB account specifies the location of the databases together with the security information required to access those databases.

Inside an account, you create one or more databases. You create one or more containers inside each database. You store documents in containers.

:::image type="content" source="../media/2-cosmos-db-resource-hierarchy.svg" alt-text="Conceptual image of parent-child relationship of account, database, and container in Cosmos D B.":::

Each container is organized as a series of partitions. Partitions *roughly* correspond to the physical files on disk. A large partition might have its file, but several small partitions could be combined into a single file. Each document has a partition key that defines the partition to which it belongs. You use partitioning to store related documents together, and to help optimize the way you access data.

For example, in a retail database, if you store customer documents and the documents describing their orders in a container, you could consider partitioning the documents by customer ID. If you needed to fetch customer and order information together for a specific customer, you could fetch the data from the same partition.

### Azure Cosmos DB throughput

Azure Cosmos DB uses the concept of **Request Units per second** (RU/s) to manage the performance and billing of databases. This measure abstracts the underlying physical resources that need to be provisioned to support the required performance. When you create a database or container, you specify how many RU/s to allocate. You'll incur charges accordingly.

## Azure Cosmos DB APIs

Azure Cosmos DB supports several programmatic APIs. These APIs conform as closely as possible to the APIs used by other common NoSQL databases. The intention is to provide an easy migration pathway to Azure Cosmos DB from these databases, without developers having to learn a new paradigm, or make significant changes to their applications. The APIs currently supported are:

- MongoDB
- Cassandra
- Gremlin (a common graph DB API)
- Azure Table Storage
- SQL

The SQL API is a variant of the SQL language used by most relational database management systems. There are restrictions and adaptations for handling sets of schemaless documents rather than tables.

## Use Visual Studio Code to manage Azure Cosmos DB

If you're using Visual Studio Code as your development environment for building Azure Cosmos DB databases and applications, you can install the Azure Databases extension.

:::image type="content" source="../media/2-azure-databases-visual-studio-code-extension.png" alt-text="Screenshot of the Azure Databases extension in Visual Studio Code marketplace":::

You install the extension from the Extensions Marketplace for Visual Studio Code.

The Azure Databases extension provides a graphical user interface that is integrated with Visual Studio Code. Using the extension, you can create, delete, and manage Azure Cosmos DB accounts, databases, containers, and documents.

:::image type="content" source="../media/2-cosmosdb-extension.png" alt-text="Screenshot of the Azure Databases extension in Visual Studio Code as user right-clicks on the Documents node for a contextual menu to create a new document." loc-scope="vs-code":::
