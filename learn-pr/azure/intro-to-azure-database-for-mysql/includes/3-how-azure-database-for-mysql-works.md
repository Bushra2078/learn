In this unit, you'll explore how Azure Database for MySQL works. If you're using MySQL and are considering using Azure to host your MySQL apps, you must choose between one of the following hosting methods:

- PaaS, by using Azure Database for MySQL - Flexible Server
- IaaS, by using MySQL on Azure VMs

In this unit, you'll learn more about the differences between these hosting options. You'll also learn about the functions and features they provide, along with their specific requirements.

## How are the hosting options different?

You can deploy MySQL on Azure in different ways. The following table identifies the key characteristics of each of these approaches.

| Hosting option            | Summary                                                                              |
| ---------------------------------------------------------------------------------------------------------------- |
| Azure Database for MySQL | Fully managed DBaaS, but providing more user configuration and control, if required.  |
| MySQL on Azure VMs       | A database implementation that uses IaaS and is managed by you.                       |

Let's examine more closely the differences in features:

- MySQL version:

  - All deployment options support versions 5.7 and 8.0.
  - MySQL on Azure VMs supports any MySQL version you want to install.
- Compute scaling. All options can scale as necessary to accommodate load changes.
- Network connectivity:
  - All options support public endpoints with a server firewall.
  - Private access with Private Link support is available for MySQL on Azure VMs.
  - Private access with Virtual Network integration is available for Flexible Server.
- SSL/TLS connectivity is supported on all platforms.
- Storage:
  - Azure Database for MySQL support storage sizes between 5 gigabytes (GiBs) to 16 terabytes (TiBs). It also support online storage scaling.
  - MySQL on Azure VMs supports from 32 GiB to 32,767 GiB but doesn't support online storage scaling.

- Updating and patching:
  - OS updates:
    - Automatic for Azure Database for MySQL - Flexible Server.
    - Managed by end users for MySQL on Azure VMs.

  - MySQL patching:
    - Automatic for Azure Database for MySQL - Flexible Server.
    - Managed by end users for MySQL on Azure VMs.

- High availability:
  - Azure Database for MySQL supports built-in high availability with multiple availability zones.
  - MySQL on Azure VMs requires that you custom-manage these settings.
- Data encryption at rest:
  - Azure Database for MySQL supports this with service-managed keys.
  - MySQL on Azure VMs doesn't support this.
- Backup:
  - On Flexible Server, backups are automated with retention between 1 and 35 days.
  - On MySQL on Azure VMs, backups are managed manually.

## Azure Database for MySQL architecture

Let's examine the Azure Database for MySQL architecture. In the following diagram, an instance of Azure Database for MySQL is deployed. It's configured with Azure Premium Storage for data and logs. MySQL also has access to locally redundant storage for backup.

The MySQL instance is hosted in Availability zone 1. Other availability zones are present, and Azure Database for MySQL could use those as well. Various client apps are connected to the MySQL instance.

:::image type="content" source="../media/flexible-server.png" alt-text="This is a detailed architecture of Azure Database for MySQL in a typical organization as previously described.":::

### How high availability works

For Flexible Server, within the single availability zone, the following steps occur after a hosting server failure:

1. Azure provisions a new VM.
2. Azure maps the storage and data files to the new VM.
3. Azure brings the MySQL database engine online.
4. Client apps reconnect to the new MySQL instance.

> [!NOTE]
> If you have provisioned high availability across zones, the hot standby server is maintained in another availability zone in the same Azure region.

### How backups work

You're then able to use the backups to restore your server to any point in time within the retention period (35 days).

### How scaling works

Azure Database for MySQL is available in three SKUs.

The SKUs are:

- Burstable. Best suited for low-cost development and low concurrency workloads that don't need full compute capacity continuously.
- General Purpose. Better suited for production workloads requiring high concurrency, scale, and predictable performance.
- Business Critical. Better suited for production workloads requiring high concurrency, scale, and predictable performance.

Depending on the SKU, you can configure the desired settings, and then adjust the scale settings as required to meet your application needs.

Next, let's consider whether Azure Database for MySQL is suitable for your organization, its apps, and its database workloads.
