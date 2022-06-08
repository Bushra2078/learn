Azure Database for PostgreSQL writes all database changes to a log file before committing the changes to disk. This is called the write ahead logging. In this module you have learned how PostgreSQL prevents data loss in the event of a problem by using the write ahead log. You have learned about high availability, and how this uses the write ahead log to replicate your data. You have learned about logical decoding, and how you can configure your server to stream data. You have also learned how to set up a second server, and replicate data from your main server to your second server to maintain a second copy of your data.

After completing this module, you are now to:

- Describe write ahead logging
- Understand replication and logical decoding

For more information about the topics covered in this module, see:

- [Optimize bulk inserts - Azure Database for PostgreSQL - Single Server | Microsoft Docs](/azure/postgresql/howto-optimize-bulk-inserts)
- [Logical replication and logical decoding - Azure Database for PostgreSQL - Flexible Server | Microsoft Docs](/azure/postgresql/flexible-server/concepts-logical)
- [Overview of zone redundant high availability with Azure Database for PostgreSQL - Flexible Server | Microsoft Docs](/azure/postgresql/flexible-server/concepts-high-availability)
- [Manage read replicas - Azure portal - Azure Database for PostgreSQL - Single Server | Microsoft Docs](/azure/postgresql/howto-read-replicas-portal)
- [Change data capture in Postgres: How to use logical decoding and wal2json - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/azure-database-for-postgresql/change-data-capture-in-postgres-how-to-use-logical-decoding-and/ba-p/1396421#:~:text=Here%E2%80%99s%20what%20the%20logical%20decoding%20process%20looks%20like%3A,that%20change%20is%20passed%20to%20the%20output%20plugin.)
