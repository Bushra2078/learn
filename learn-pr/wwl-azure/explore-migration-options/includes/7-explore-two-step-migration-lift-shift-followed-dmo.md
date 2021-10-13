Consider the following for the two-step migration:

 -  Ensure connectivity to Azure is available via Express Route (recommended) or VPN.
 -  Provision the target infrastructure on Azure which includes the cloned system and target SAP NetWeaver and SAP HANA database servers. The Azure infrastructure can be deployed using predefined ARM templates.
 -  The cloned system can be built with a homogeneous system copy (backup/restore) or via DBMS replication tools (e.g. Oracle Data Guard or SQL Always-On).
 -  Business and technical testing should be initiated (with functional, integration and acceptance testing to ensure the move of data has been successful).
 -  Following business and technical validation, the traditional DMO process can be followed to migrate and upgrade to SAP HANA.
 -  DMO can be leveraged with the memory pipe method (i.e. export/import occurs within the same application server and memory segment for accelerated migrations).
 -  Following the migration to SAP HANA, business and technical validation should again be initiated.
 -  In this approach, two downtimes and two testing cycles are required.

## DMO optimization options

There are many factors that influence the downtime associated with an SAP database migration and include (amongst others):

:::row:::
  :::column:::
    **Scope**
  :::column-end:::
  :::column:::
    **Software changes, Unicode conversion, data center relocation**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Source system performance
  :::column-end:::
  :::column:::
    CPU, I/O, memory, DBMS performance, SAP NetWeaver release
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Source system database size
  :::column-end:::
  :::column:::
    Database size, largest tables, status of housekeeping
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Target system performance
  :::column-end:::
  :::column:::
    CPU, I/O, memory, DBMS performance, SAP NetWeaver release
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Network
  :::column-end:::
  :::column:::
    Network speed, bandwidth, latency
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Toolset
  :::column-end:::
  :::column:::
    SWPM, SUM, DMO of SUM, version of the toolset
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Migration approach
  :::column-end:::
  :::column:::
    Standard vs Minimize Downtime
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Ramp-up / Ramp-down
  :::column-end:::
  :::column:::
    Activities Interface management, batch job management
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Pre and post migration validation
  :::column-end:::
  :::column:::
    Functional, integration and acceptance Testing.
  :::column-end:::
:::row-end:::


Broadly speaking, the potential for performance optimizations can be seen in the following three areas:

 -  Export
 -  File Transfer
 -  Import

## Infrastructure/hardware

The infrastructure/hardware reduction lever consists of the following:

### On-premises

 -  Deploy a dedicated migration server (PAS / AAS) with extensive compute capability to execute SUM
 -  Deploy Solid State Disks (SSD) on the source database and migration servers.
 -  (PAS / AAS)

### Microsoft Azure

 -  **Express Route connectivity** is recommended with the maximum bandwidth available (currently available up to 10 Gbps)
 -  Leverage the dmotocloud.sh script (RSYNC) to move files from an on-premise source to an Azure target for the DMO System Move Option with Parallel Transfer.
 -  **Implement storage snapshots** for time-efficient backups during the cutover period.

## Key considerations for downtime optimization for DMO

 -  Source database optimization (index rebuild, DB statistics, DB parameters, DB file system). A useful reference can be found in the table below.

:::row:::
  :::column:::
    **Database**
  :::column-end:::
  :::column:::
    **Reference**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Oracle
  :::column-end:::
  :::column:::
    [SAP Note \#936441](https://launchpad.support.sap.com/#/notes/936441)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    DB2
  :::column-end:::
  :::column:::
    [DB2 Optimization Techniques for SAP Database Migration And Unicode Conversion](http://www.redbooks.ibm.com/abstracts/sg247774.html)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SQL Server
  :::column-end:::
  :::column:::
    [SAP OS/DB Migration to SQL Server–FAQ v6.2 April 2017](/archive/blogs/saponsqlserver/sap-osdb-migration-to-sql-server-faq-v6-2-april-2017)
  :::column-end:::
:::row-end:::


 -  Use the latest version of migration tools, R3\*, kernel, etc.
 -  Network parameterization (e.g. MTU settings, reset counters)
 -  OS-related parameterization (e.g. Q depth)
 -  SAP HANA database parameters (related to save points, log mode, and timeouts)
 -  DMO Migration parameters (e.g/ duration files, manual table splits, manual table sequencing order, fast load for BLOB, etc.)

## DMO Benchmarking:

 -  Used to capture export and import phases for a subset of data. It can be configured to run on specific tables.

## Repeat multiple runs of downtime phase:

 -  Running the execution phase multiple times is possible by reworking the table splitting activity (thus optimizing table splitting that will reduce the downtime of the DMO procedure).
