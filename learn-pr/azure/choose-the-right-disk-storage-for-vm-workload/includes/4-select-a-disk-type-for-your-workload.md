Let's examine in detail the disk type choices architects must make for a proposed Azure application.

In your healthcare organization, you have a business critical system that manages stocks of prescription drugs and ensures that practitioners have them available at all times in their local clinics. Suppose that the system runs on servers in your on-premises datacenter. Now, you want to lift-and-shift the system into Azure with as little modification as possible. You want to create a set of virtual machines in Azure that match the current physical servers and then migrate the system. Before the migration, you want to select the right disk types for each virtual machine.

In this unit, you'll examine the requirements for each virtual server in the proposed cloud-based system and see why a particular disk type is optimal.
 
![On-premises servers for the prescription drugs stocks database](../media/4-on-premises-servers.png)

## Production database server

First, you want to architect the virtual machine that will host the production database for your prescription drug stocks system. This system is business-critical and used by the majority of your employees, all around the world, to do their jobs. The database server in the on-premises system is heavily utilized and the physical disks run close to their capacity in terms of IOPS and throughput. The database also contains highly sensitive patient data, so you want to ensure that it is encrypted on the disk.

You've monitored and analyzed the performance of your on-premises system, both during typical periods and during periods of peak demand, such as during a successful marketing campaign. This study shows that fast disks and low latency underpin the system and that any drop in performance will impact on all your users. To ensure that your current good performance continues after the migration to the cloud, you want the disks that store the databases to support 50,000 IOPS and throughputs up to 1000 MBps. 

This requirement makes the decision simple: the maximum size for premium SSDs is P80, but this size supports maximum IOPS of 20,000 and a maximum throughput of 900 MBps. Only the largest sizes of ultra SSDs support the performance you need. 

Remember that ultra SSDs can only be attached to virtual machines in availability zones. This requirement provides high availability, because the virtual servers are not vulnerable to a datacenter-wide hardware failure. It also means that you should use managed disks, which Azure automatically replicates across the availability zones where virtual machines are hosted. Managed disks also support the encryption you need.

## Data warehouse servers

Next, you want to consider the servers that host the prescription drug data warehouse: data from the production database is regularly exported to this data warehouse and restructured to make it easier to analyze long-term trends. These servers also host data cubes that are designed to support your complex reporting needs. 

In your on-premises system, there is a data warehouse server in your main datacenter and also several in regional offices. You've created a virtual machine image for these data warehouse servers and you will use it to simplify the deployment of multiple instances of the virtual machine in multiple Azure regions. Your analysis indicates that these servers require high-performance disks, but not the extreme performance required by the production database server.

The highest performance disks in Azure are premium SSDs and ultra SSDs. However, ultra disks don't currently support virtual machine images. Therefore premium SSDs are the optimal disk type for data disks in this workload. None of your requirements for data warehousing require unmanaged disks, so you choose managed disks to reduce administrative overhead.

## Standby database server

In your on-premises system, you have a standby server that runs a replica of the main prescription drug stocks database. On the rare occasions when the main server fails, database queries are redirected to this server so that users experience no interruption in service. You want a similar standby virtual machine in your cloud-based system.

Because this virtual machine will not be used most of the time, you've been asked to implement it within a limited budget. Your architects consider that a drop in performance is acceptable during rare failures of the primary virtual machine. 

You find that the budget is unlikely to stretch to premium SSDs. In these circumstances, standard SSDs are the best choice, because they have equal or better performance than the equivalent size of standard HDD and more consistent performance.

You carefully consider whether it's possible to make further saving by using unmanaged disks but you remember that this database should be encrypted wherever it's stored. That encryption requires managed disks.

## Administrative web interface

The on-premises system includes a set of stored procedures that implement maintenance routines on the data. There is also a set of data views that administrators use to monitor the performance of the database. To make life easier for administrators, there is a web server in your on-premises system that hosts a site that administrators can use to run these stored procedures and view performance reports. You want to migrate this server into the cloud and host it on an Azure virtual machine.

Again you want to minimize costs. The site is used only by the team of 20 administrators and places low load on its disk drives, which are used only to store the web application's code files. You are happy to have an interruption in service from this web server for a period after a failure. 

In this case, you can minimize costs by using standard HDDs in the web server. You can also consider using unmanaged disks - it may be possible to reduce storage costs by carefully controlling the storage account where the data resides, but consider that you must spend more administrative time setting up and maintaining unmanaged disks.
