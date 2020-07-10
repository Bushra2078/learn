In this module you learned about the performance capabilities of Azure SQL compared to SQL Server. You also learned fundamental performance tasks such as configuration and maintenance.

Monitoring and troubleshooting are important to deliver consistent performance so in this module you learned the various methods and tools to monitor and troubleshoot performance with hands-on activities for a CPU scaling scenario. You then learned how to improve CPU scaling for your workload without any migration required for your database. Improving application performance does not always require a new scale in Azure so you learned a common performance bottleneck scenario that you improved by tuning the query workload.

Finally, you learned the unique capabilities of Intelligent Performance in Azure SQL including Intelligent Query Processing, Automatic Plan Correction, and Automatic Indexing.

## Learn more

Learn more about Azure SQL Performance with these resources:

- Fixed capacities to choose from for CPU, memory, and I/O. Study the resource limits for Azure SQL [Managed Instances](https://docs.microsoft.com/azure/azure-sql/managed-instance/resource-limits) and [Databases](https://docs.microsoft.com/azure/azure-sql/database/resource-limits-vcore-single-databases).
- [I/O configuration](https://techcommunity.microsoft.com/t5/datacat/storage-performance-best-practices-and-considerations-for-azure/ba-p/305525) for Managed Instance may improve performance.
- Familiar tools exist like DMVs and [Extended Events](https://docs.microsoft.com/azure/azure-sql/database/xevent-db-diff-from-svr).
- [Query Store](https://docs.microsoft.com/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store) is on by default and powers features like Automatic Tuning.
- Azure functionality like [Azure Metrics](https://docs.microsoft.com/azure/azure-monitor/platform/data-platform-metrics) can be used to replace functionality like Windows Performance Monitor
- DMVs exist that are new and designed for Azure such as [sys.dm_db_resource_stats](https://docs.microsoft.com/sql/relational-databases/system-dynamic-management-views/sys-dm-db-resource-stats-azure-sql-database?view=azuresqldb-current).
- New wait types exist specific to Azure such as [LOG_RATE_GOVERNOR](https://docs.microsoft.com/azure/azure-sql/database/resource-limits-logical-server#transaction-log-rate-governance).
- [Scale](https://docs.microsoft.com/azure/azure-sql/database/scale-resources) up and down without need to migrate.
- Take advantage of Intelligent Performance to get faster. [Automatic Tuning](https://docs.microsoft.com/azure/azure-sql/database/automatic-tuning-overview) uses Machine Learning to recommend important performance best practices such as indexes.