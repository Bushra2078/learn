Azure Site Recovery can replicate your virtual machine workloads between Azure regions. You can also use Site Recovery to migrate VMs from other environments, such as on-premises infrastructure, to Azure.  You'll see that Site Recovery can be used for much more than just a backing up and restoring infrastructure.

Your organization recently suffered an outage caused by a hurricane. You'll identify the Site Recovery features required to protect your Azure virtual machines (VMs) by enabling failing over to a secondary Azure region.

In this unit, you'll learn about the Site Recovery features that will help to handle future outages.

## Site Recovery features

![Diagram showing a VM environment becoming unavailable and failing over to a secondary environment](../media/2-failover.png)

Site Recovery manages the orchestration of disaster recovery in Azure. It is designed to replicate workloads from a primary site or region, to a secondary site. If the primary site has an issue, Site Recovery can replicate protected VMs to another Azure region.

Site Recovery manages the replication of Azure VMs between regions, or the replication of on-premises VMs to Azure and back again. Because it's built natively into Azure, Site Recovery can run seamless tests (disaster recovery drills) without affecting production workloads.

### Azure virtual machine protection

Site Recovery will protect your VM instances in Azure automatically. Site Recovery mirrors the source VM configuration, and creates required or associated resource groups, storage accounts, virtual networks, and availability sets to a secondary Azure region. The resources created are appended with a Site Recovery suffix.

### Snapshots and recovery points

Site Recovery has customizable replication policies that allow you to define the retention history of recovery points, and the frequency of snapshots. A recovery point is created from a snapshot of a VMs disk. The two types of snapshots available are **App-consistent** and **Crash-consistent**.

- **Crash-consistent** recovery represents the data on-disk at the time the snapshot is taken. The default snapshots are captured every five minutes.

- **App-consistent** recovery captures the same data as crash-consistent but also includes all in-memory data and in-process transactions. Including the in-memory data means Site Recovery can restore a VM and any running apps without any data loss. The default snapshots are captured every 60 minutes.

All recovery points are kept for 24 hours by default, although this period can be extended to 72 hours.

### Replication to a secondary region

When replication is enabled for an Azure VM, the Site Recovery mobility service extension is installed. The installed extension will register the VM with Site Recovery. The process for continuous replication of the VM then begins, so any writes to the disk are immediately transferred to a local storage account. This account is used as a cache by Site Recovery, the cache is replicated to a storage account in the destination environment.

Site Recovery copies data stored in the cache and syncs it with either the target storage account or replicated managed disks. After the data is processed, crash-consistent recovery points are created. If app-consistent recovery points are enabled, they'll be generated on a schedule as set in the Site Recovery replication policy.

Site Recovery can use accelerated networking for Azure virtual machines, reducing jitter and decreasing CPU utilization.

### Disaster recovery (DR) drills

Site Recovery allows you to perform disaster recovery drills, after all pre-requisite configuration tasks are complete. Running a DR drill enables you to validate the replication strategy for your environment without losing data, having downtime, or compromising your production environment. Drills don't affect your production environment, and are great way to test that you have correctly configured everything.

### Flexible failover and failback

Site Recovery failover and failback can be easily started using the Azure portal. When running a failover, you select a recovery point then let Site Recovery take care of the failover. Failback is simple a reverse of this process. When a failover is successful and has been committed, it is available to failback.
