You can choose whether to let Azure manage the storage infrastructure for your virtual hard disks, or manage that infrastructure yourself. 

Suppose you have a variety of virtual machines running heathcare workloads in your on-premises network that you want to migrate to Azure. In most cases, you're happy to let Azure manage virtual hard disks. However, you have a database server that hosts a large database. You've been asked to keep a close control over the storage for this database so that you can manage costs carefully. You're also interested in minimizing storage costs for two servers that host a microservice for your accounting application.

In this unit, you'll see how to choose between managed and unmanaged disks. You'll also learn about disk roles and ephemeral disks.

## Managed disks

Most disks that you use with virtual machines in Azure are managed disks. A managed disk is a virtual hard disk for which Azure manages all the required physical infrastructure. Because Azure takes care of the underlying complexity, managed disks are easy to use: you can just provision them and attach them to virtual machines.

Virtual hard disks in Azure are stored as page blobs in an Azure Storage account, but you don't have to create storage accounts, blob containers, and page blobs yourself or maintain this infrastructure later. The benefits of managed disks include:

- **Simple scalability.** You can create up to 50,000 managed disks of each type in each region in your subscription. 
- **High availability.** Managed disks support 99.999% availability, by storing data three times. If there is a failure in one replica, the other two can maintain full read/write functionality.
- **Integration with availability sets and zones.** If you place your virtual machines into an availability set, Azure automatically distributes the managed disks for those machines into different fault domains, so that your machines are resilient to localized failures. You can also use availability zones, which distribute data across multiple datacenters, for even greater availability.
- **Support for Azure Backup.** Azure Backup natively supports managed disks, including encrypted disks. 
- **Granular access control.** You can use Azure Role-Based Access Control (RBAC) to grant access to specific user accounts for specific operations on a managed disk. For example, you could ensure that only an administrator can delete a disk.
- **Support for encryption.** To protect sensitive data on a managed disk from unauthorized access, you can encrypt it by using Azure Storage Service Encryption (SSE), which is provided with Azure Storage accounts. Alternatively, you can use Azure Disk Encryption (ADE), which uses BitLocker for Windows virtual machines, and DM-Crypt for Linux virtual machines.

Because of all these features, use managed disks by default.

## Unmanaged disks

An unmanaged disk, like a managed disk, is stored as a page blob in an Azure Storage account, but unlike a managed disk, you create and maintain this storage account manually. 

Because unmanaged disks do not support all of the scalability and management features that you have seen for managed disks, they are no longer widely used. Consider using them only if you want to manually set up and manage the data for your virtual machine in the Storage Account. 

In the portal, to use unmanaged disks, expand the **Advanced** section on the **Disks** page of the **Create a virtual machine wizard**:

![Using unmanaged disks in the Azure portal](../media/2-using-unmanaged-disks.png)

Unmanaged disks might be a good fit for the database server you want to migrate. Because you can set up the storage account manually, it might be possible to make storage savings. However, consider that you may need to devote extra administrative time to this virtual machine, because Azure does not manage the storage infrastructure for you.

> [!NOTE]
> Originally, all virtual hard disks in Azure were unmanaged so, if you are using an old virtual machine, it may have unmanaged disks. You can convert those unmanaged disks to managed disks by using a PowerShell cmdlet:
>
> ```PowerShell
> ConvertTo-AzureRmVMManagedDisk -ResourceGroupName LegacyResources -VMName OldVM
> ```
>

## Disk roles

Each disk can take one of three roles in a virtual machine:

- **OS Disk.** One disk in each virtual machine contains the operating system files. When you create a virtual machine, you select a virtual machine image and that fixes the operating system and the OS disk that is attached to the new machine. The OS disk has a maximum capacity of 2,048 GB.
- **Data Disk.** You can add one or more data virtual disks to each virtual machine to store data. For example, database files, web site static content, or custom application code should be stored on data disks. The number of data disks you can add depends on the virtual machine size. Each data disk has a maximum capacity of 32,767 GB.
- **Temporary Disk.** Each virtual machine contains a single temporary disk, which is used for short-term storage applications such as page files and swap files. The contents of temporary disks are lost during maintenance events so do not use these disks for critical data. Temporary disks are unmanaged in Azure. 

<!-- TODO: Screenshot of these disks in disk manager within a VM -->

## Ephemeral OS disks

An ephemeral disk is a virtual disk in the OS disk role that does not save data to an Azure Storage account. Instead, an ephemeral OS disk saves data on the local virtual machine storage. 

An ephemeral disk has faster read and write latency than a managed disk. It is also faster to reset the image to the original boot state if you're using an ephemeral disk. Finally, an ephemeral disk incurs no storage costs. However, an individual virtual machine failure may destroy all the data on an ephemeral disk and leave the virtual machine unable to boot.

Ephemeral disks work well when you want to host a stateless workload, such as the business logic for a multi-tier website, or a microservice. Such applications are tolerant of individual virtual machine failures, because requests can be rerouted to other virtual machines in the system. You can reset the failed virtual machine to its original boot state rapidly and get it back up and running faster than if it used managed disks. 

Consider using an ephemeral OS disk for the accounting application microservice. 