 Azure includes a number of native tools to facilitate the disciplines or phases of the migration process: assess workloads, migrate workloads, and release workloads. Those tools start with Azure Migrate, but includes a number of integrated first and third-party tools.

## Azure Migrate

Azure includes a number of native tools to facilitate the disciplines or phases of the migration process: assess workloads, migrate workloads, and release workloads ("cut over"). Azure Migrate provides a centralized hub to assess, migrate, and release to from on-premises servers, virtual machines from other clouds, applications, and data. In addition to Azure Migrate teams also often include a number of integrated first and third-party tools.

Azure Migrate provides the following:

- **Unified migration platform:** A single portal to start, run, and track your migration to Azure.
- **Range of tools:** A range of tools for assessment and migration. Azure Migrate tools include Azure Migrate: discovery and assessment and Azure Migrate: Server Migration. Azure Migrate also integrates with other Azure services and tools, and with independent software vendor (ISV) offerings.
- **Assessment and migration:** In the Azure Migrate hub, you can assess and migrate:
  - **Servers:** Assess on-premises servers or VMs running on other clouds and migrate them to Azure Virtual Machines or Azure VMware Solution (AVS) (preview).
  - **Databases:** Assess on-premises databases and migrate them to Azure SQL Database or to SQL Managed Instance.
  - **Web applications:** Assess on-premises web applications and migrate them to Azure App Service by using the Azure App Service Migration Assistant.
  - **Virtual desktops:** Assess your on-premises virtual desktop infrastructure (VDI) and migrate it to Windows Virtual Desktop (WVD) in Azure.
  - **Data:** Migrate large amounts of data to Azure quickly and cost-effectively using Azure Data Box products.

## Integrated tools

The Azure Migrate hub includes these tools:

**Tool** | **Assess and migrate** | **Details**
--- | --- | ---
**Azure Migrate: Discovery and Assessment** | Assess servers. | Discover and assess on-premises VMware VMs, Hyper-V VMs, and physical servers in preparation for migration to Azure.  This can also be used to assess servers from other cloud platforms with a view to migrate to Azure.
**Azure Migrate: Server Migration** | Migrate servers. | Migrate VMware VMs, Hyper-V VMs, physical servers, other virtualized machines, and public cloud VMs to Azure.
**Data Migration Assistant** | Assess SQL Server databases for migration to Azure SQL Database, Azure SQL Managed Instance, or Azure VMs running SQL Server. | Data Migration Assistant helps pinpoint potential problems blocking migration. It identifies unsupported features, new features that can benefit you after migration, and the right path for database migration.
**Azure Database Migration Service** | Migrate on-premises databases to Azure VMs running SQL Server, Azure SQL Database, or SQL Managed Instance. | Azure Database Migration Service enables a seamless migration from multiple database sources to Azure data platforms with minimal downtime.
**Movere** | Assess servers. | Helps to provide data and insights need to plan cloud migrations.
**Web app migration assistant** | Assess on-premises web apps and migrate them to Azure. |  Use Azure App Service Migration Assistant to assess on-premises websites for migration to Azure App Service. Use Migration Assistant to migrate .NET and PHP web apps to Azure.
**Azure Data Box** | Migrate offline data. | Use Azure Data Box products to move large amounts of offline data to Azure.

> [!NOTE]
> If you're in Azure Government, external integrated tools and ISV offerings can't send data to Azure Migrate projects. You can use tools independently.

## ISV integration

Azure Migrate also integrates with several ISV offerings.

| ISV | Feature |
|--|--|
| Carbonite | Migrate servers. |
| Cloudamize | Assess servers. |
| Corent Technology | Assess and migrate servers. |
| Device42 | Assess servers. |
| Lakeside | Assess VDI. |
| RackWare | Migrate servers. |
| Turbonomic | Assess servers. |
| UnifyCloud | Assess servers and databases. |

## Azure Migrate: Discovery and assessment tool

The Azure Migrate: Discovery and Assessment tool discovers and assesses on-premises VMware VMs, Hyper-V VMs, VMs hosted on other public clouds and physical servers for migration to Azure.

Here's what the tool does:

- **Azure readiness:** Assesses whether on-premises machines are ready for migration to Azure.
- **Azure sizing:** Estimates the size of Azure VMs or number of Azure VMware nodes after migration.
- **Azure cost estimation:** Estimates costs for running on-premises servers in Azure.
- **Dependency analysis:** Identifies cross-server dependencies and optimization strategies for moving interdependent servers to Azure.

Azure Migrate: Discovery and Assessment uses a lightweight Azure Migrate appliance that you deploy on-premises.

- The appliance runs on a VM or physical server. You can install it easily using a downloaded template.
- The appliance discovers on-premises machines. It also continually sends machine metadata and performance data to Azure Migrate.
- Appliance discovery is agentless. Nothing is installed on discovered machines.
- After appliance discovery, you can gather discovered machines into groups and run assessments for each group.

## Azure Migrate: Server Migration tool

The Azure Migrate: Server Migration tool helps you migrate to Azure:

| Migrate | Details |
|--|--|
| On-premises VMware VMs | Migrate VMs to Azure using agentless or agent-based migration. For agentless migration, Server Migration uses the same Azure Migrate appliance that can also be used by Azure Migrate: Discovery and Assessment for discovery and assessment of VMware VMs. For agent-based migration, Server Migration uses a replication appliance. |
| On-premises Hyper-V VMs | Migrate VMs to Azure. Migrate VMs running on Hyper-V hosts to Azure using Hyper-V Replication Provider. |
| Physical servers and VMs (in public or private cloud) | You can migrate physical machines to Azure. You can also migrate other virtualized machines, and VMs from other public clouds, by treating them as physical servers for the purpose of migration. | Server Migration uses a replication appliance for the migration. |

Together, these tools will facilitate the technical aspects of the each discipline or phase of the migration.
