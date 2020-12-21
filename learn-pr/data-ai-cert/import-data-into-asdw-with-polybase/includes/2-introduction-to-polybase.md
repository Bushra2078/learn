The data warehouse component of Azure Synapse Analytics service is a relational big data store that uses a massively parallel processing (MPP) architecture. It takes advantage of the on-demand elastic scale of Azure compute and storage resources to load and process petabytes of data. With Azure Synapse Analytics, you get quicker access to the critical information you need to make good business decisions.

> [!NOTE]
> There are two versions of compute nodes that are available at the time of writing. Both Azure Synapse Analytics Generation 1 (Gen1) and Generation 2 (Gen2) can have 60 compute nodes assigned to process data when the maximum Data Warehouse Unit (DWU) is selected. Gen2 is a newer architecture that has five times the compute capacity and four times the concurrent queries of Gen1.

A key feature of Azure Synapse Analytics is that you pay for only the processing you need. You can decide how much parallelism is needed for your work. You also can pause the compute nodes when it's not in use. In this way, you pay for only the CPU time you use.

Azure Synapse Analytics supports many loading methods. These methods include non-PolyBase options such as BCP and the SQL Bulk Copy API. The fastest and most scalable way to load data is through PolyBase. PolyBase is a technology that accesses external data stored in Azure Blob storage, Hadoop, or Azure Data Lake Store via the Transact-SQL language.

> [!VIDEO https://channel9.msdn.com/Shows/Learn-Azure/Introduction-to-Polybase/player?format=ny]

The following architecture diagram shows how loading is achieved with each HDFS bridge of the data movement service (DMS) on every compute node that connects to an external resource such as Azure Blob storage. PolyBase then bidirectionally transfers data between Azure Synapse Analytics and the external resource to provide the fast load performance.

![Loading Azure Synapse Analytics via PolyBase](../media/2-load-azure-dw-via-polybase.png)

## Use PolyBase to extract, load, and transform data

Follow these steps to implement a PolyBase extract, load, and transform process for Azure Synapse Analytics:

1. Extract the source data into text files.
2. Load the data into Azure Blob storage, Hadoop, or Azure Data Lake Store.
3. Import the data into Azure Synapse Analytics staging tables by using PolyBase.
4. Transform the data (optional).
5. Insert the data into production tables.

Let's look more closely at the import process defined by steps 1-3.
