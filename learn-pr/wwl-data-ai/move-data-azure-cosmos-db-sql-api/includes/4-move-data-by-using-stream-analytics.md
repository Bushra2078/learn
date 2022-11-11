**Azure Stream Analytics** is a real-time event-processing engine designed to process fast streaming data from multiple sources simultaneously. It can aggregate, analyze, transform, and even move data around to other data stores for more profound and further analysis.

## Setup

Azure Stream Analytics supports multiple output sinks including Azure Cosmos DB for NoSQL.

> [!NOTE]
> As of this time, only the NoSQL API is supported.

### Configuration

Configuring the Azure Cosmos DB for NoSQL output consists of either selecting the account within your subscription or providing your credentials, which commonly include:

| **Property** | **Description** |
| ---: | :--- |
| ``Output alias`` | An alias to refer to this output in the query |
| ``Account ID`` | Account endpoint URI |
| ``Account Key`` | Account key |
| ``Database`` | Name of the database resource |
| ``Container name`` | Name of the container |

The database and container must already exist in the Azure Cosmos DB for NoSQL account before using the output sink.

## Write to Azure Cosmos DB

Query results from Azure Stream Analytics will be processed as JSON output when written to Azure Cosmos DB for NoSQL.

Additionally, items are **upserted** to Azure Cosmos DB for NoSQL based on the value of the **id** field. Items are typically inserted into Azure Cosmos DB for NoSQL. If an item already exists with the same unique id, then the operation is assumed to be an **update** operation instead of an **insert** operation.
