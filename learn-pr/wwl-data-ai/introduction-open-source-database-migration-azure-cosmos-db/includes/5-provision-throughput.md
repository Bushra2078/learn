Request Units (RUs) and storage form the two parts of the Azure Cosmos DB charging model. Storage costs are easy to calculate because they are based on the storage size in gigabytes per month. If you store double the amount of data in a month, the storage cost will double assuming the rates have remained static.

RUs are more complex to calculate because they are based upon a combination of memory, processing, and input/output operations per second (IOPS). One RU is the cost to read a 1-KB item based upon your resources. Having said that, if you modify data there will be a variable number of RUs depending upon the specific action being performed.

For more information, see [Estimate Request Units and Data Storage](https://aka.ms/AA58ejk)

## RU considerations

The number of RUs per second will be affected by the following factors:

### Item size
Larger items will consume more RUs to read or write.

### Item indexing
Indexing is automatic for all items, but if you specify not to index an item, it will consume fewer RUs.

### Consistency levels
The most consistent Strong and Bounded Staleness consistency levels consume approximately double the number of RUs when compared to other consistency levels.

### Queries, stored procedures, and triggers
The same query on the same data will always consume the same RUs, but queries with bigger result sets, many and/or complex predicates, and including user-defined functions will consume more RUs.
