Let's start with a few definitions and a quick tour through Azure Cosmos DB SQL API. This overview should help you see whether Azure Cosmos DB might be a good fit for your work.

## What is a NoSQL database?

Developers require new kinds of databases that can address the needs of modern apps. NoSQL databases were designed to address these needs and unique challenges such as:

- High volumes of data
- Data with many different sources and forms
- Dynamic data schemas to store different types of data
- Using high-velocity and/or real-time data

NoSQL databases are defined by common characteristics they share rather than a specific formal definition. These characteristics include:

- Data store is non-relational
- Designed for scale-out
- Does not enforce a specific schema

NoSQL databases generally do not enforce relational constraints or put locks on data, making writes fast. They are also often designed for horizontally scale via sharding or partitioning, which allows them to maintain high-performance regardless of size.

While there are many NoSQL data models, four broad data model families are commonly used when modeling data in a NoSQL database:

:::image type="content" source="../media/2-nosql-db.svg" alt-text="Diagram showing various NoSQL models including; a key-value, document, graph, and column-family store." border="false":::

Moving forward, we will focus on the document data model, the data model supported by Azure Cosmos DB SQL API

## Why use a NoSQL database with the document data model?

The document data model breaks data down into individual **document** entities. A document can be any structured data type, but JSON is commonly used as the data format. The Azure Cosmos DB SQL API supports JSON natively.

:::image type="content" source="../media/2-document-db.svg" alt-text="Illustration of a hierarchical document data model that includes parent entities, child entities, and lines connecting them." border="false":::

A document is an atomic entity and can have its own data form, regardless of what is stored in other documents in the same database. Because of this flexibility, there is no need for a pre-defined schema making it easier to build new applications rapidly. Additionally, this flexibility enables scenarios where different types of data can be stored together and where models can evolve over the lifetime of an application.

## What is a JSON document?

JavaScript Object Notation, or [JSON][json.org], is a lightweight data format. JSON was built to be highly compatible with the literal notation of an object in the JavaScript language. Many frameworks, browsers, and even databases support JavaScript natively making JSON a popular format for transmitting and storing data.

Here is an example of a JSON document:

:::code language="json" source="../media/3-document.json" range="18-27":::

As you can see, JSON is a relatively readable data format that clearly exposes its content. JSON is also relatively easy to parse and use in JavaScript applications.

## What is Azure Cosmos DB SQL API?

Azure Cosmos DB SQL API is a fast NoSQL database service that offers rich querying over diverse data, helps deliver configurable and reliable performance, is globally distributed, and enables rapid development.

:::image type="content" source="../media/2-azure-cosmos-db.svg" alt-text="Illustration of a world map with four globally distributed nodes that are connected via lines." border="false":::

The SQL API is the core or native API for working with documents. The SQL API supports fast, flexible development utilizing JSON documents, a query language with a familiar syntax, and client libraries for popular programming languages. Azure Cosmos DB provides other APIs, such as Mongo, Gremlin, and Cassandra, that offer compatibility with each database ecosystem while still mapping to the same underlying infrastructure of the native SQL API.

Azure Cosmos DB SQL API has a few advantages such as:

- **Guaranteed speed at any scale**—even through bursts—with instant, limitless elasticity, fast reads, and multi-master writes, anywhere in the world
- **Fast, flexible app development** with SDKs for popular languages, a native SQL API along with APIs for MongoDB, Cassandra, and Gremlin, and no-ETL (extract, transform, load) analytics
- **Ready for mission-critical applications** with guaranteed business continuity, 99.999-percent availability, and enterprise-grade security
- **Fully managed and cost-effective serverless database** with instant, automatic scaling that responds to application needs

These capabilities make Azure Cosmos DB ideally suited for modern application development. Azure Cosmos DB SQL API is especially suited for applications that:

- Experience unpredictable spikes and dips in traffic
- Generate lots of data
- Need to deliver real-time user experiences
- Are depended upon for business continuity

The Azure Cosmos DB SQL API can arbitrarily store native JSON documents with flexible schema. Data is indexed automatically and is available for query using a flavor of the SQL query language designed for JSON data. The SQL API can be accessed using SDKs for popular frameworks such as [.NET][azure/cosmos-db/sql/sql-api-sdk-dotnet-standard], [Python][azure/cosmos-db/sql/sql-api-sdk-python], [Java][azure/cosmos-db/sql/sql-api-sdk-java-v4], and [Node.js][azure/cosmos-db/sql/sql-api-sdk-node].

[azure/cosmos-db/sql/sql-api-sdk-dotnet-standard]: /azure/cosmos-db/sql/sql-api-sdk-dotnet-standard
[azure/cosmos-db/sql/sql-api-sdk-java-v4]: /cosmos-db/sql/sql-api-sdk-java-v4
[azure/cosmos-db/sql/sql-api-sdk-node]: /azure/cosmos-db/sql/sql-api-sdk-node
[azure/cosmos-db/sql/sql-api-sdk-python]: /azure/cosmos-db/sql/sql-api-sdk-python
[json.org]: https://www.json.org
