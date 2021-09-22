A core feature of multiuser databases is concurrency. Concurrency uses locking and blocking to enables data to remain consistent with many users updating and reading data at the same time. For example, due to shipping costs all of our products have a $5 price increase. At the same time, due to currency rates, all products have a 3% price decrease. If these updates happen at exactly the same time, the final price will be variable and there are likely to be numerous errors. Using locking, you can ensure that one update will complete before the other one begins.

The unit of work that concurrency operates on is a transaction. A transaction that is updating some data can block other transactions from updating or reading that data and, equally, a transaction that is reading some data could block other transactions from updating that data. For this reason, it is important to avoid unnecessarily long transactions or transactions which span excessive amounts of data.

There are many specific transaction isolation levels that can be used to define how a database system handles multiple users, but, for the purposes of these module, we will look at to broad categories of isolation level, optimistic locking and pessimistic locking.

## Optimistic concurrency

With optimistic locking there is an assumption that few conflicting updates will occur. At the start of the transaction, the initial state of the data is recorded. Before the transaction is committed the current state is compared with the initial state. If the states are the same, the transaction is completed. If the states are different, the transaction is rolled back.

For example, you have a table containing last years sales orders. This data is very infrequently updated, but reports are run often. By using optimistic locking transactions do not block each other and the system runs more efficiently. Unfortunately, errors have been found in last years data and updates need to take place. While one transaction is updating every row another transaction makes a minor edit to a single row at the same time. Because the state of the data was changed while the initial transaction was running, the whole transaction is rolled back.

## Pessimistic concurrency

With pessimistic locking there is an assumption that many updates are happening to the data at the same time. By using locks only one update can happen at the same time and reads of the data are prevented while updates are taking place. This can prevent large rollbacks, as seen in the previous example, but can cause queries to be blocked unnecessarily.

It is important to consider the nature of your data and the queries running on the data when deciding whether to use optimistic or pessimistic concurrency to ensure optimum performance.

## Snapshot isolation

There are five different isolation levels in SQL Server, but for this module we will concentrate on just READ_COMMITTED_SNAPSHOT_OFF and READ_COMMITTED_SNAPSHOT_ON. READ_COMMITTED_SNAPSHOT_OFF is the default isolation level for SQL Server. READ_COMMITTED_SNAPSHOT_ON is the default isolation level for Azure SQL Database.

READ_COMMITTED_SNAPSHOT_OFF will hold locks on the affected rows until the end of the transaction if q query is using the read committed transaction isolation level. While it is possible for some updates to occur, such as the creation of a new row, this will prevent most conflicting changes to the data being read or updated. This is pessimistic concurrency.

READ_COMMITTED_SNAPSHOT_ON takes a snapshot of the data. Updates are then performed on that snapshot allowing other connections to query the original data. At the end of the transaction the current state of the data is compared to the snapshot. If the data is the same, the transaction is committed. If the data differs, the transaction is rolled back.

To change the isolation level to READ_COMMITTED_SNAPSHOT_ON issue the following command:

```sql
ALTER DATABASE *db_name* SET READ_COMMITTED_SNAPSHOT ON;
```

To change the isolation level to READ_COMMITTED_SNAPSHOT_OFF issue the following command:

```sql
ALTER DATABASE *db_name* SET READ_COMMITTED_SNAPSHOT OFF;
```

If the database has been altered to turn read committed snapshot on, any transaction that uses the default read committed isolation level will use optimistic locking.

> [!NOTE]
> Snapshot isolation only occurs for read committed transactions. Transactions that use other isolation levels are not affected.
