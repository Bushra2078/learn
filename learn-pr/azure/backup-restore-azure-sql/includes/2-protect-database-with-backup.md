The retail organization that you work for uses Azure SQL Database to store the relational data for its enterprise resource planning (ERP) system. The company uses this system for all its accounting, customer relationship management, sales management, and corporate governance procedures. If this data were lost, the business would suffer huge losses and might even have to cease operations. 

The board has given you responsibility for the protection of this data. You want to be sure that if a disaster happens, you can restore all the data up to the failure within three hours.

Here, you'll learn about Azure SQL Database backups and how to use them effectively.

## Storage for Azure SQL Database backups

SQL Database automatically creates database backups. The backups are kept for 7 to 35 days. The retention time depends on the purchasing model and the service tier that you choose when you create your database. When the backups are complete, they're stored as blobs in a read-access geo-redundant storage (RA-GRS) account in your Azure subscription. To help protect against a datacenter outage, they're replicated to a paired datacenter.

Azure SQL Database uses SQL Server technology to make these types of backups:

- **Full backups**: In a full backup, everything in the database and the transaction logs is backed up. SQL Database makes a full backup once a week.
- **Differential backups**: In a differential backup, everything that changed since the last full backup is backed up. SQL Database makes a differential backup every 12 hours.
- **Transactional backups**: In a transactional backup, the contents of the transaction logs are backed up. SQL Database makes a transaction log backup every 5 to 10 minutes. Transactional backups enable administrators to restore up to a specific time, which includes the moment before data was mistakenly deleted.

You can use these backups to:

- Restore an existing database.
- Restore a deleted database up to the time when it was deleted.
- Restore the database to an alternative location or region.
- Restore a database from a long-term backup by using long-term retention (LTR). 

When a failure occurs, you might lose changes from up to 5 minutes ago, if the live transaction logs are lost. If the transaction logs are intact, you can restore up to the moment that the failure occurred.

## Backups and service tiers

The default backup retention period is set to 7 days when you create a database. Later, you can change that period to a duration from 0 to 35 days. When you create a database by using the purchasing model based on Data Transaction Units (DTUs), the default retention period for that database depends on the service tier:

| Service tier  | Default retention period  |
|---------------|---------------------------|
| Basic         | 1 week                  |
| Standard      | 5 weeks                |
| Premium       | 5 weeks                |

## How often do backups happen?

There are backups for point-in-time restore, and there are backups for long-term retention.

SQL databases fully support point-in-time restore. They automatically create full backups, differential backups, and transaction log backups. The first full backup is scheduled as soon as the database is created. It usually finishes within 30 minutes, but it might take longer if the database is of significant size. 

After the first full backup, all further backups are scheduled automatically and managed silently in the background. The SQL Database service determines the exact timing of all database backups, because it balances the overall system workload. You can't change or disable the backup jobs.

Full backups for LTR are kept up to 10 years in Azure Blob storage accounts. You can configure the LTR policy to perform automatic weekly full backups. The storage of LTR backups depends on the frequency and the retention period that you choose.

## Storage costs

Microsoft provides Azure Backup services to create all-encompassing backups with a predictable pricing system that lets you easily keep track of any Azure data backup costs. Pricing for Azure Backup for SQL Server is based on paying for both instance costs (the data getting protected) and storage costs each month.

Seven days of automated backups of your databases are copied to RA-GRS standard blob storage by default. The storage is used by weekly full backups, daily differential backups, and transaction log backups copied every 5 minutes. The size of the transaction log depends on the rate of change of the database. 

A minimum storage amount equal to 100 percent of database size is provided at no extra charge. Additional consumption of backup storage is charged in gigabytes per month.

## Benefits of using Azure backups

Azure backups offer the following benefits:

- You can reduce your infrastructure costs, because there are minimal upfront costs and minimal operational expenses.
- You can use a range of features to help ensure that your data is backed up, secure, and stored in a separate location from your database.
- You can store three copies of your data in three different locations in the primary Azure datacenter. You can store another three copies in an alternative remote Azure datacenter. This arrangement protects against all but the most severe disasters.
- Your data is encrypted before it leaves the source database, whether it's in transit or held in the Azure backup vault.
