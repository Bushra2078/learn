Let's start with an overview of IoT development challenges and the Azure SQL Edge features that help you overcome those challenges. This should help you decide whether Azure SQL Edge might be a good fit for your work. Azure SQL Edge can help those organizations interested in innovating in the IoT space. It provides a data platform that's:

- Flexible enough to support the full range of IoT scenarios.
- Powerful enough to support edge compute.
- Secure enough to help meet the privacy needs of IoT applications.
- Fully compatible with a familiar ecosystem of products, tools, and services.

## What are the challenges of IoT development?

IoT systems can be found in many organizations, including those in:

- Retail
- Finance
- Manufacturing
- Energy
- Government
- Education

These organizations use IoT devices to work with data that originates in many ways, including:  

- Smart factories.
- Remote medical assistance.
- Predictive maintenance.
- Analyzing satellite images.
- Autonomous vehicles.
- Point-of-sale devices.
- Monitoring wind farms and solar-energy panels.
- Onsite inventory system.
- Home security.

There's a wide range of industry sectors and of IoT devices in use. This makes it challenging for developers to create secure and consistent apps to work with these devices. Often, developers resort to using proprietary database systems to manage this data. This means they often must learn new skills on new platforms. It also sometimes results in a compromise of performance and security.

The following table identifies common challenges that developers face when working with IoT devices in these contexts.

| Challenge                                                    | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| IoT apps require a powerful database engine                  | Many IoT apps require near real-time analytics. Other apps require the ability to gather data when disconnected from backend systems. In these and other use cases, sending all data to the cloud can be very costly and bandwidth-intensive. This means that the IoT devices need access to a local database engine that must be lightweight and powerful. |
| IoT apps require seamless connectivity to the backend ecosystem | IoT apps can be significantly constrained if they can't easily connect to, and communicate with, backend systems in an organization's datacenter or their hosted cloud services, or both. Therefore, it's vital that any system you implement at the edge on IoT devices can communicate with industry-standard database systems. |
| IoT apps can run in insecure environments                    | Many IoT apps might run in cars, hospitals, and factories, where security and privacy are primary requirements. Therefore, the platform you select to work with data in these environments must be secure, and users and developers must trust it.
| Building solutions on unfamiliar platforms                   | Many existing IoT platforms rely on solution-specific APIs and databases that developers don’t know well. These solutions might also require specific language skills that developers don’t yet have. It's important that any apps you deploy to interact with edge-based IoT devices are built using standard components and tools with which developers are already familiar. |

## Azure SQL Edge definition

Azure SQL Edge is a data engine that:

- Has a small footprint.
- Is edge-optimized.
- Supports machine learning <!-- ID/SME: Just a note that per the Microsoft Cloud Style guide, when referring generically to machine learning, we shouldn't use an acronym. -->.

Azure SQL Edge shares the same codebase as SQL Server and SQL Database. Therefore, developers with skills in SQL Server or SQL Database can reuse their code to build your organization's edge-specific solutions on Azure SQL Edge. Using it means you develop your apps once and deploy them potentially anywhere.

:::image type="content" source="../media/compatible.png" alt-text="A graphic depicting Azure SQL, SQL Server, and Azure SQL Edge.":::

> [!IMPORTANT]
> Although Azure SQL Edge is built on the same codebase as SQL Server and SQL Database, the use cases for these products are different. Azure SQL Edge is optimized for IoT use cases and workloads. SQL Server and SQL Database, in contrast, are built for mission-critical, data-management solutions and line-of-business (LOB) apps.

## How to use Azure SQL Edge to address IoT development challenges

Azure SQL Edge helps address IoT development challenges by:

- Supporting solutions that work with, or without, network connectivity.
- Helping secure movement of the local edge data to on-premises datacenters or Azure.
- Providing support for standard tooling, programming languages, and a familiar query language (T-SQL). This helps provide compatibility with existing code.

   > [!TIP]
   > Azure SQL Edge supports a large subset of the T-SQL surface area with which developers are familiar.

- Enables AI and analytics at the edge. <!-- ID/SME: Just a note. You had "artificial intelligence" spelled out. However, per the Microsoft Cloud Style guide, it's doesn't need to be spelled out on first reference. The acronym is OK to use for all references. -->
- Includes native support for ingesting time-series data.
- Delivers excellent security and provides support for regulatory compliance.

> [!NOTE]
> Beyond these compatibilities, you also can use familiar BI tools such as Microsoft Power BI and Tableau software. Your developers also can use tools such as Azure Data Studio, SQL Server Management Studio, and Visual Studio.
