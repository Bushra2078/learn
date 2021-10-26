SAP systems moved onto the Azure cloud now commonly include large multinational “single global instance” systems and are many times larger than the first customer systems deployed when the Azure platform was first certified for SAP workloads some years ago.

Very Large Databases (VLDB) are now commonly moved to Azure. Database sizes over 20 TB require some additional techniques and procedures to achieve a migration from on-premises to Azure within an acceptable downtime and a low risk.

## High level overview

A fully optimized VLDB migration should achieve around 2 TB per hour migration throughput per hour or possibly more. This means the data transfer component of a 20 TB migration can be done in approximately 10 hours. Various postprocessing and validation steps would need to be done. In general, with adequate time for preparation and testing almost any customer system of any size can be moved to Azure.

VLDB migrations require considerable skill, attention to detail, and analysis. For example, the net effect of table splitting must be measured and analyzed. Splitting a large table into more than 50 parallel exports may considerably decrease the time taken to export a table, but too many table splits may result in drastically increased import times. Therefore the net effect of table splitting must be calculated and tested. An expert licensed OS/DB migration consultant will be familiar with the concepts and tools. We will highlight some Azure specific content for VLDB migrations.

In particular, we will deal with heterogeneous OS/DB migration to Azure with SQL Server as the target database using tools such as R3load and Migmon. The migration steps are not intended for homogenous system copies, a copy where the DBMS and processor architecture (Endian Order) stays the same. In general, homogeneous system copies should have low downtime regardless of DBMS size, because log shipping can be used to synchronize a copy of the database in Azure.

A block diagram of a typical VLDB OS/DB migration and move to Azure is illustrated below. The following are the key points:

 -  The current source OS/DB is often AIX, HPUX, Solaris, or Linux; and DB2 or Oracle.
 -  The target OS is either Windows, Suse 12.3, Redhat 7.x, or Oracle Linux 7.x.
 -  The target DB is usually either SQL Server or Oracle 12.2.
 -  IBM pSeries, Solaris SPARC hardware, and HP Superdome thread performance is drastically lower than low-cost modern Intel commodity servers, therefore R3load is run on separate Intel servers.
 -  VMware requires special tuning and configuration to achieve good, stable, and predictable network performance. Typically physical servers are used as R3load server and not VMs.
 -  Commonly four export R3load servers are used, though there is no limit on the number of export servers. A typical configuration would be:
    
     -  Export server 1 – dedicated to the largest 1-4 tables (depending on how skewed the data distribution is on the source database)
     -  Export server 2 – dedicated to tables with table splits
     -  Export server 3 – dedicated to tables with table splits
     -  Export server 4 – all remaining tables
 -  Export dump files are transferred from the local disk in the Intel based R3load server into Azure using AzCopy via public internet (this is typically faster than via ExpressRoute, though not in all cases).
 -  Control and sequencing of the import is via the signal file (SGN) that is automatically generated when all export packages are completed. This allows for a semi-parallel export/import.
 -  Import to SQL Server or Oracle is structured similarly to the export, using four import servers. These servers would be separate dedicated R3load servers with Accelerated Networking. It is recommended not to use the SAP application servers for this task.
 -  VLDB databases would typically use E64v3, m64, or m128 VMs with Premium Storage. The transaction log can be placed on the local SSD disk to speed up transaction log writes and remove the transaction log IOPS and IO bandwidth from the VM quota. After the migration, the transaction log should be placed onto a persisted disk.

:::image type="content" source="../media/block-typical-very-large-database-os-database-migration-fd67f4cc.png" alt-text="Block diagram of a typical VLDB OS DB migration and move to Azure":::
