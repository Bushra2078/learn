In order to understand more "What is Azure SQL?" and deployment options it is important to know important terms from the Azure ecosystem. After learning about the ecosystem, you'll dive deeper into what Azure SQL is and the deployment options that are available.  


### The Azure Ecosystem 

The Azure ecosystem includes accounts, subscriptions, interfaces, resource management, and more for a wide variety of Azure services. Azure SQL is a family of services within the Azure ecosystem.

#### Azure Accounts and Subscriptions

An Azure account is required to deploy and use Azure services. Each azure account has one or more subscriptions. Subscriptions provide a unit of billing and organization for Azure resources. You can read more about Azure subscription management in the [documentation](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/initial-subscriptions).

#### Azure Portal 

The Azure Portal is the primary user interface to interact with the Azure ecosystem. The Azure Portal can be viewed with a [web browser](https://portal.azure.com), [Windows application](https://portal.azure.com/App/Download), or [mobile application](https://azure.microsoft.com/en-us/features/azure-portal/mobile-app).

#### Azure Marketplace 

All Azure services are consumed through a marketplace including Microsoft and 3rd party services. When you select an option in the portal to create a new resource from an Azure service you are using the Azure Marketplace.

####  Azure APIs and CLIs 

All Azure services support Application Programming Interfaces (API). A common thread for all Azure Services is native support for a Representational State Transfer ([REST](https://docs.microsoft.com/en-us/rest/api/azure)) API. In addition, two common Command Line Interfaces (CLI) that work across Azure services are the [az CLI](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest) and [Powershell Azure cmdlets](https://docs.microsoft.com/en-us/powershell/azure).

#### Azure Resource Manager (ARM) 

Azure provides an infrastructure for all Azure services for deployment, management, security, and logging called the [Azure Resource Manager](https://azure.microsoft.com/en-us/features/resource-manager/) (ARM). One of the most common concepts provided by ARM you will use in this workshop is called a **resource group**. ARM also provides a system for automated deployments through ARM templates. ARM also provide a robust access control system called **Role Based Access Control (RBAC)**.

#### Azure Monitor 

The Azure ecosystem provides a system for Azure services to collect and manage metrics and events including a logging system called [Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/overview). Logs can be queried using a common language called [Kusto](https://docs.microsoft.com/en-us/azure/kusto/query/) (KQL). Azure SQL integrates with the Azure Monitor system.

#### Azure Regions and Datacenters 

Azure services are deployed in a [global infrastructure](https://azure.microsoft.com/en-us/global-infrastructure/) in physical buildings called **datacenters**. Datacenters are organized in geographical locations around the world in [regions](https://azure.microsoft.com/en-us/global-infrastructure/regions/). Your target for deployment will always be a region. For maximum availability, regions are often paired. Datacenters also provide additional layers of protection through a concept called an [availability zone](https://azure.microsoft.com/en-us/global-infrastructure/availability-zones/).

#### Azure SLA  

Formal documents called [Service-Level Agreements](https://azure.microsoft.com/en-us/support/legal/sla/) (SLAs) capture the specific terms that define the performance standards that apply to Azure.

SLAs describe Microsoft's commitment to providing Azure customers with specific performance standards.
There are SLAs for individual Azure products and services.
SLAs also specify what happens if a service or product fails to perform to a governing SLA's specification. Azure SQL has specific SLAs that apply to availability and performance which you will learn about in this workshop.


### What is Azure SQL? 

Within the umbrella of the "Azure SQL" term, there are many deployment options and choices to be made in order to tailor to various customers' needs. While there are a lot of options, this is not meant to confuse or complicate things, but rather to give customers the flexibility to get and pay for exactly what they need. This topic will cover some of the challenges and scenarios that lead to choosing various Azure SQL deployment options, as well as some of the technical specifications for each of those options. The deployment options discussed in this topic include SQL Server on Azure virtual machines, Azure SQL managed instances, Azure SQL Databases, and Azure SQL "pools" (Azure SQL Instance Pools and Azure SQL Elastic Pools).  

![Azure SQL umbrella of offerings](../media/azuresql.png)  

At the highest level, when you're considering your options, the first question you may ask is, "What level of scope do I want?" As you move from virtual machines to managed instances to databases, your management scope decreases. With virtual machines, you not only get access to but are also responsible for the OS and the SQL Server. With managed instance, the OS is abstracted from you and now you have access to only the SQL Server. And the highest abstraction is SQL database where you just get a database, and you don't have access to instance-level features or the OS.  

#### SQL Server on Azure virtual machine

![When to choose SQL Server on Azure virtual machine](../media/sqlvm1.png)  

*[Extended Security Updates](https://www.microsoft.com/en-us/cloud-platform/extended-security-updates) worth 75% of license every year for the next three years after End of Service (July 9, 2019). Applicable to Azure Marketplace images, customers using customer SQL Server 2008/R2 custom images can download the Extended Security Updates for free and manually apply.  
**[GigaOm Performance Study](https://gigaom.com/report/sql-transaction-processing-price-performance-testing/)

SQL Server on Azure Virtual Machines is simply a version of SQL Server that you specify running in an Azure VM. It's just SQL Server, so all of your SQL Server skills should directly transfer, though we can help automate backups and security patches. SQL Server on Azure virtual machines are referred to as [Infrastructure as a Service (IaaS)](https://azure.microsoft.com/en-us/overview/what-is-iaas/). You are responsible for updating and patching the OS and SQL Server (apart from critical SQL security patches), but you have access to the full capabilities of SQL Server.

There are some considerations for optimally deploying and managing SQL Server on Azure Virtual Machines including:

- Install from [Azure gallery images](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#4-configure-sql-server-settings) or take advantage of the [Resource Provider](http://www.aka.ms/sqlvm_rp_documentation) for licensing flexibility and to enable automatic backups and updates.
- Consider the Memory or Storage optimized Virtual Machine [sizes](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/series/) for maximum performance requirements.
- Use the right [storage configuration](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-storage-configuration) including taking advantage of Azure Blob Storage Read Caching.
- Integrate your Azure Virtual Machines to on-premises networks using [Azure Virtual Networks](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview#communicate-with-on-premises-resources).
- Take advantage of Automated Backups, Backups to Azure Blog Storage, and integration with [Azure Backup](https://azure.microsoft.com/en-us/blog/azure-backup-for-sql-server-in-azure-virtual-machines-now-generally-available/).
- Always On Failover Cluster Instance is supported with [Azure Premium File Share](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-create-failover-cluster-premium-file-share).
- [Always On Availabilty Groups](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-availability-group-overview) are supported including a Cloud Witness.

The customer example for SQL Server on Azure Virtual Machine is [Allscripts](https://customers.microsoft.com/en-us/story/allscripts-partner-professional-services-azure). Allscripts is a leading healthcare software manufacturer, serving physician practices, hospitals, health plans, and Big Pharma. To transform its applications frequently and host them securely and reliably, Allscripts wanted to move to Azure quickly. In just three weeks, the company lifted and shifted dozens of acquired applications running on ~1,000 virtual machines to Azure with [Azure Site Recovery](https://azure.microsoft.com/en-us/services/site-recovery/).

This isn't the focus of this workshop, but if you're considering SQL Server on Azure Virtual Machine, you'll want to review the [guidance on images to choose from](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-iaas-overview), the [quick checklist](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-performance) to obtain optimal performance of SQL Server on Azure VMs, and the guidance for [storage configuration](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-storage-configuration).  

> Note: If you're specifically looking at SQL Server on RHEL Azure VMs, there's a full operations guide available [here](https://azure.microsoft.com/en-us/resources/sql-server-on-rhel-azure-vms-operations-guide/
).  

#### IaaS vs PaaS

SQL Server on Azure virtual machines are considered IaaS. The other deployment options in the Azure SQL umbrella (Azure SQL managed instance and Azure SQL Database) are [Platform as a Service (PaaS)](https://azure.microsoft.com/en-us/overview/what-is-paas/) deployments. These PaaS Azure SQL deployment options use fully managed Database Engine that automates most of the database management functions such as upgrading, patching, backups, and monitoring. Throughout this course, you'll learn much more about the benefits and capabilities that the PaaS deployment options enable and how to optimally configure, manage, and troubleshoot them, but some highlights are listed below:  

* [Business continuity](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-business-continuity) enables your business to continue operating in the face of disruption, particularly to its computing infrastructure.
* [High availability](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-high-availability) of Azure SQL Database guarantees your databases are up and running 99.99% of the time, no need to worry about maintenance/downtimes.
* [Automated backups](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-automated-backups) are created and use Azure read-access geo-redundant storage (RA-GRS) to provide geo-redundancy.
* [Long term backup retention](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-long-term-retention) enables you to store specific full databases for up to 10 years.
* [Geo-replication](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-active-geo-replication) by creating readable replicas of your database in the same or different data center (region).
* [Scale](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-scale-resources) by easily adding more resources (CPU, memory, storage) without long provisioning.
* Network Security
    * [Azure SQL Database (single database and elastic pool)](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-security-overview#network-security) provides firewalls to prevent network access to the database server until access is explicitly granted based on IP address or Azure Virtual Network traffic origin.
    * [Azure SQL Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-connectivity-architecture) has an extra layer of security in providing native virtual network implementation and connectivity to your on-premises environment using [Azure ExpressRoute](https://docs.microsoft.com/en-us/azure/expressroute/) or [VPN Gateway](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways).
* [Advanced security](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-security-index) detects threats and vulnerabilities in your databases and enables you to secure your data.
* [Automatic tuning](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-automatic-tuning) analyzes your workload and provides you the recommendations that can optimize performance of your applications by adding indexes, removing unused indexes, and automatically fixing the query plan issues.
* [Built-in monitoring](https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-azure-sql) capabilities enable you to get the insights into performance of your databases and workload, and troubleshoot the performance issues.
* [Built-in intelligence](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-intelligent-insights) automatically identifies the potential issues in your workload and provides you the recommendations that can [help you to fix the problems](https://azure.microsoft.com/en-us/blog/ai-helped-troubleshoot-an-intermittent-sql-database-performance-issue-in-one-day/).  

#### Versionless  
One additional difference that is significant between IaaS and PaaS is the idea of *versionless* SQL. Unlike IaaS, which is tied to a specific SQL Server version (e.g. 2019), Azure SQL Database and Managed Instance (all PaaS SQL services) are versionless. The main "branch" of the SQL Server engine code base powers SQL Server 2019, Azure SQL Database, and Azure SQL Managed Instance. 

While SQL Server versions come out every few years, PaaS services allow Microsoft to constantly update the SQL databases/instances. Microsoft rolls out fixes and features as appropriate on what they call "trains". As a consumer of the service, you don't have control over this, and the result of `@@VERSION` will not line up to a specific SQL Server version. However, this allows for *worry-free patching for both the underlying OS and SQL Server* and for Microsoft to give you the latest bits, taking the responsibility to also not break you. 

As new features are developed, some customers can be whitelisted for specific features (Microsoft calls this Private Preview). New features, after Private Preview, will become Public Preview, where everyone can access them, but there is limited support and often discount pricing (if applicable). Some new features are applicable to Azure and SQL Server, while some are specific to Azure. For updates, some things make it to a Cumulative Update first and some to Azure first. To see a feed from Microsoft regarding updates, [refer here](https://azure.microsoft.com/en-us/updates/?category=databases). Another helpful resources are the [Release Notes](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-release-notes?tabs=single-database) for Azure SQL Database.


#### Azure SQL managed instance

![When to choose Azure SQL Managed Instance](../media/sqlmi1.png)  

[Azure SQL managed instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance) is a PaaS deployment option of Azure SQL that basically gives you an evergreen instance of SQL Server. Most of the features available in the SQL Server box products are available in Azure SQL managed instance (Azure SQL MI). This option is ideal for customers who want to leverage instance-scoped features (features that are tied to an instance of SQL Server as opposed to features that are tied to a database in an instance of SQL Server) like SQL Server Agent, Service Broker, Common Language Runtime (CLR), etc. and want to move to Azure without rearchitecting their applications. While Azure SQL MI allows customers to access the instance-scoped features, customers do not have to worry about (nor do they have access to) the OS or the infrastructure underneath.     

> **Fun fact**: You might be wondering why it is called *Managed Instance*. Let's break it down:  
> - It is called an *Instance* because it is equivalent to a Database Engine Instance of SQL Server which is defined in our [documentation](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/database-engine-instances-sql-server?view=sql-server-ver15). The term Database Engine Instance is important because other instance types for SQL Server are things like [SSAS](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fanalysis-services%2Finstances%2Fanalysis-services-instance-management%3Fview%3Dasallproducts-allversions&data=02%7C01%7CAnna.Hoffman%40microsoft.com%7Cb3514821e4e04a2de26108d7dc094dfe%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637219804823187896&sdata=Zz8gwcuGFo%2BCZ9rZ8DBjNKKvmvP7VrwwRDZVkiGOs0k%3D&reserved=0).  
>- It's called *Managed* because it is a PaaS version of a Database Engine Instance where we manage several things including install of SQL Server, scaling, and high-availability.  


A good customer example comes from [Komatsu](https://customers.microsoft.com/en-us/story/komatsu-australia-manufacturing-azure). Komatsu is a manufacturing company that produces and sells heavy equipment for construction. They had multiple mainframe applications for different types of data, which they wanted to consolidate to get a holistic view. Additionally, they wanted a way reduce overhead. Because Komatsu uses a large surface area of SQL Server features, they chose to move to **Azure SQL Managed Instance**. They were able to move about 1.5 terabytes of data smoothly, and [start enjoying benefits like automatic patching and version updates, automated backups, high availability, and reduced management overhead](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-technical-overview). After migrating, they reported ~49% cost reduction and ~25-30% performance gains.  

#### Azure SQL Database

![When to choose Azure SQL Database](../media/sqldb1.png)  

Azure SQL Database is a PaaS deployment option of Azure SQL that abstracts both the OS and the SQL Server instance away from the users. Azure SQL Database has the industry's highest availability [SLA](https://azure.microsoft.com/en-us/support/legal/sla/sql-database/v1_4/), along with other intelligent capabilities related to monitoring and performance, due in part to the fact that Microsoft is managing the instance. This deployment option allows you to just 'get a database' and start developing applications. Azure SQL Database (Azure SQL DB) is also the only deployment option that currently supports scenarios related to needing unlimited database storage ([Hyperscale](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tier-hyperscale)) and autoscaling for unpredictable workloads ([serverless](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-serverless)).  

[AccuWeather](https://customers.microsoft.com/en-us/story/accuweather-partner-professional-services-azure) is a great example of using Azure SQL Database. AccuWeather has been analyzing and predicting the weather for more than 55 years. They wanted access to the rich and rapidly advanced platform of Azure that includes big data, machine learning, and AI capabilities. They want to focus on building new models and applications, not managing databases. They selected **Azure SQL Database** to use with other services, like [Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/) and [Azure Machine Learning Services](https://docs.microsoft.com/en-us/azure/machine-learning/service/), to quickly and easily deploy new internal applications to make sales and customer predictions.  

#### Azure SQL "pools"

You've now learned about the three main deployment options within Azure SQL: virtual machines, managed instances, and databases. For the PaaS deployment options (Azure SQL MI and Azure SQL DB), there are additional options for if you have multiple instances or databases, and these options are referred to as "pools". Using pools can help at a high level because they allow you to share resources between multiple instances/databases and cost optimize.  

[Azure SQL Instance Pools](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-instance-pools) (currently in public preview) allow you to host multiple Azure SQL MIs and share resources. You can pre-provision the compute resources which can reduce the overall deployment time and thus make migrations easier. You can also host smaller Azure SQL MIs in an Instance Pool than in just a single Azure SQL MI (more on this in future sections).

[Azure SQL Database Elastic Pools](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-pool) (Generally Available) allow you to host many databases that may be multi-tenanted. This is ideal for a [Software as a Service (SaaS)](https://azure.microsoft.com/en-us/overview/what-is-saas/) application or provider, because you can manage and monitor performance in a simplified way for many databases.  

A good example for where a customer leveraged Azure SQL Database Elastic Pools is [Paychex](https://customers.microsoft.com/en-us/story/paychex-azure-sql-database-us). Paychex is a human capital management firm that serves more than 650,000 businesses across the US and Europe. They needed a way to separately manage the time and pay management for each of their customers, and cut costs. They opted for [**Azure SQL Database Elastic Pools**](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-pool), which allowed them to simplify the management and enable resource sharing between separate databases to lower costs.  


### Azure SQL Deployment Options - Summary

In this section, you've learned about Azure SQL and the deployment options that are available to you. A brief visual that summarizes the deployment options is below. In the next section, we'll go through deploying and configuring Azure SQL and how it compares to deploying and configuring the box SQL Server.  

!Azure SQL deployment options including pools](../media/azuresql2.png)

If you want to dive deeper into the deployment options and how to choose, check out the following resources:  
* [Blog announcement for Azure SQL](https://techcommunity.microsoft.com/t5/Azure-SQL-Database/Unified-Azure-SQL-experience/ba-p/815368) which explains and walks through Azure SQL and some of the resulting views and experiences available in the Azure portal.
* [Microsoft Customer Stories](https://customers.microsoft.com/en-us/home?sq=&ff=&p=0) for many more stories similar to the ones above. You can use this to explore various use cases, industries, and solutions.  
* [Choose the right deployment option in Azure SQL](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-paas-vs-sql-server-iaas) is a page in the documentation regularly updated to help provide insight into making the decisions between the Azure SQL options.
* [Choosing your database migration path to Azure](https://azure.microsoft.com/mediahandler/files/resourcefiles/choosing-your-database-migration-path-to-azure/Choosing_your_database_migration_path_to_Azure.pdf) is a white paper that talks about tools for discovering, assessing, planning, and migrating SQL databases to Azure. This workshop will refer to it several times, and it's a highly recommended read. Chapter 5 deeply discusses choosing the right deployment option.  
* [Feature comparison between SQL database, SQL managed instance, and SQL Server](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-features) 
