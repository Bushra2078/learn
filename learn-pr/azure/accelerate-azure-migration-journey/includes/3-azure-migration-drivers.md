A crucial part of building a cloud migration and modernization strategy for an organization is to identify what's triggering cloud adoption. Some triggers might prompt quick action, while others might call for a more active, hands-on approach.

Business and IT-driven goals point to migration and modernization triggers, which determine the strategy for moving applications to the cloud. For IT-based triggers *migration* of your workloads is best. When you're presented with business-focused goals, we recommend *modernizating* of your applications.

![Graphic showing the two migration paths of migration or modernization.](../media/migrate-or-modern.png)

With a migration, the workloads remain unchanged and are moved to the cloud. If modernization is selected, the application code is changed, or the application could be rewritten or replaced to use new cloud technologies.

At Tailwind Traders, you could develop a decision tree, which helps you to evaluate your applications.

![Graphic of a decision tree showing platform as a service (PaaS) or infrastructure as a service (IaaS) based on future development on an application.](../media/modernize-decision-tree.png)

As the solution architect on the Tailwind Traders team, you'll need to understand the triggers for your migration or modernization.

![Graphic showing the triggers for a migration or modernization project.](../media/migration-triggers.png)

## Migration triggers

Migration triggers are typically IT-oriented or based on timelines. Often, the migration to the cloud is driven by the need to quickly reduce on-premises costs, stay secure, and simplify operations. These triggers include:

- Datacenter contract expiration.
- Cash flow challenges and resource constraints.
- Business continuity.
- Cybersecurity threats.

### Datacenter contract expiration

The expiration of a datacenter contract presents an opportunity to begin the cloud migration journey. An organization might be considering if it's worth continuing to run its datacenter if it's facing resource and cash flow challenges. Datacenters are expensive to build and maintain.

#### Eliminate recurring expenses

- Owning and managing physical datacenters can be expensive in terms of financial cost and effort.
- Datacenter contract expiration can be an inflection point to consider cloud migration. Migration to the cloud can provide almost immediate benefits in the form of cost reductions, better performance, and simpler management.
- Moving datacenter operations to the cloud frees you from recurring contract expenses. The cloud provides built-in scalability and other key management features that make it easier to run your datacenter efficiently.

### Cash flow challenges and resource constraints

One of the most effective incentives of the cloud and adopting a more flexible operating model is the opportunity to eliminate large upfront investments in physical infrastructure assets. Identifying areas to optimize costs and free up resources for growth and innovation is critical to establishing your business case for migrating to the cloud. Often companies struggle to meet their growth needs or can't provide the resources requested by IT teams. The cloud changes this situation with the almost infinite scale of the Azure datacenters.

#### Shift from CAPEX to OPEX

Maintaining a physical datacenter can cause serious cash flow challenges with investments reserved for infrastructure. Moving to the cloud helps you shift from capital expenses (CAPEX) to an operational expenditures (OPEX) model because you're no longer paying for a physical datacenter's costs and its associated hardware and software. Instead, you only pay for the resources you use on the cloud and can scale up or down as needed. These options provide more cash flow flexibility across an organization.

![Graphic showing the shift from CAPEX to OPEX.](../media/capex-to-opex.png)

### Business continuity

Moving to the cloud can help ensure security and resilience for business-critical workloads. Interruptions in day-to-day operations caused by issues like network connectivity and data loss can result in productivity losses and increased risk of losing critical data.

> [!IMPORTANT]
> Customers see a 66 percent reduction in recovery time on average for data hosted in Azure.

#### Resilient apps and operations

- By moving core business applications to the cloud, you can minimize disruptions and more easily maintain operations. These issues are often among the top concerns for organizations.
- By taking advantage of native disaster recovery and high-availability services, you can ensure that applications are resilient and can also scale up or down to meet performance demands.
- Azure provides options for replicating key workloads across different regions, so their uptime is maximized, and recovery options are built in. The risk of losing important apps or data is severely reduced, if not eliminated entirely.

Azure was designed for business continuity and disaster recovery with solutions built into the regions (datacenters) and many of the services, such as:

- [Azure paired regions](/azure/best-practices-availability-paired-regions?azure-portal=true)
- [Azure Storage](/azure/storage/common/storage-redundancy?azure-portal=true) for redundancy and replication
- [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/?azure-portal=true) for virtual machine replication and failover
- [Azure Backup](https://azure.microsoft.com/services/backup/?azure-portal=true) for data protection and recovery

![Diagram showing an Azure Site Recovery deployment to two regions.](../media/azure-site-recovery.png)

### Cybersecurity threats

Many security teams feel overwhelmed because of the:

- Growing evolution of cybersecurity threats.
- Increased need to protect people and resources wherever they're located.
- Difficulty in finding security talent.

The cloud provides a suite of comprehensive security options that can address many of these challenges.

#### Suite of cloud security solutions

- Traditional IT solutions are incapable of keeping up with the evolving threat landscape of advanced cyberattacks. Many businesses rightfully feel more vulnerable. The cloud offers built-in security solutions for comprehensive protection against advanced threats.
- Azure is secured with physical, infrastructure, and operational controls. Organizations can use them to take actions to ensure their applications and data are protected, backed up, and compliant.
  - [Azure Backup](https://azure.microsoft.com/services/backup/?azure-portal=true) protects your environment from ransomware attacks and recovers maliciously or accidentally deleted backup data.
  - [Azure Security Center](https://azure.microsoft.com/services/security-center/?azure-portal=true) provides unified infrastructure security management to protect your resources.
  - [Azure Sentinel](https://azure.microsoft.com/services/azure-sentinel/?azure-portal=true) provides intelligent security analytics across your entire enterprise.

## Modernization triggers

Modernization triggers are business-oriented and focused on future development or investment in the application. If you're going to continue to invest in an application by modernizing for the cloud, new features and capabilities can be created to enable business growth or improve a customer experience.

These triggers include:

- Scaling web apps and infrastructure.
- Focus on innovation
- Faster time to market
- Cost-optimizing applications

### Scale web apps and infrastructure

The ability to meet surges in demand is one of the key priorities for businesses. However, many organizations lack the confidence or technical capacity to keep up with fluctuating demands. This scenario provides yet another incentive to look to the cloud.

By using Azure, you can scale for urgent capacity needs. When you plan for peak usage through on-premises systems, your servers are typically underutilized because you need more capacity than average to accommodate spikes when they occur. The cloud releases you from this model so that you can use a scale-when-you-need-it approach.

Moving to the cloud increases your agility with an infrastructure that scales to your business needs.

#### Built-in autoscaling

Industries such as healthcare, insurance, and banking are experiencing considerable growth. Many organizations within these verticals are finding it difficult to keep pace with significant surges in demand.

By moving to managed services in the cloud, organizations can modernize their business-critical applications. They can take advantage of managed services such as [Azure App Service](https://azure.microsoft.com/services/app-service/?azure-portal=true) and [Azure SQL Database Managed Instances](https://azure.microsoft.com/services/azure-sql/sql-managed-instance/?azure-portal=true) to reduce operational tasks and focus scarce resources on higher value work.

### Focus on innovation

Here are some of the opportunities that the cloud presents if you're embarking on innovation:

- Moving to the cloud can help to significantly reduce or eliminate operational responsibilities. For this reason, you can focus on innovating your products and offering new capabilities for customers.
- Azure can help you better understand and anticipate users' needs with a full set of AI services and capabilities. You can use these capabilities to infuse your apps, websites, and bots with intelligent algorithms. You can also gain instant and continuous insights that can help inform your decisions by taking advantage of cloud-native analytics services.
- With cloud services, you can develop and deploy quickly, test safely, and iterate rapidly.
- You can gain time and resources by letting Microsoft take care of patching operating systems, upgrading operating system, and monitoring for vulnerabilities while you focus on innovation and performing tasks that can bring value to your business.

### Faster time to market

Application modernization ofter types provide the ability to provide a much faster time to market as well as being able to more quickly update applications. By modernizing on the cloud, you aren't constrained by resources that in the past may have slowed down your development efforts. You also can take advantages of service that would have taken significantly more time and resources to stand up in the past. Some examples of this may be:

- You can stand up Azure App Service in a matter of minutes to start developing a website once modernized on the platform. Previously you may have had to create a new server, patch the servers, install Internet Information Services (IIS), and make any necessary configuration changes. Now you can get to developing your application immediately rather than waiting for days to be able to start.
- Modernizing on serverless service in Azure once again provides the ability to bring solutions and updates to market much quicker by being able to quickly leverage services like Kubernetes, Functions, Logic Apps, Azure Cognitive Services, Cosmos DB and other services. Before modernizing applications on these services, it may have taken weeks of programing to implement the functionality you can gain by modernizing on these services. By rewriting your applications to take advantage of Azure serverless, you can bring an application to market it significantly less time than before.

Modernizing on Azure allows you to release applications and updates faster to keep up with or even get ahead of the competition and keep your customers happy.

### Cost-optimizing applications

While simply migrating to the cloud can help with some cash flow challenges like CAPEX and OPEX or data center renewals. Modernizing your applications can help bring cost optimization those applications. Simple moving a web server from on-premises to Azure helps CAPEX or data center contracts, but modernizing an application from a web server to Azure App Service or from SQL to Azure SQL, or servers to containers can help with being able to scale your application up and down, or better sizing your hosting to your application.

Modernizing leads to cost savings on and application-by-application basis by only paying for the resources that you need when you need them.