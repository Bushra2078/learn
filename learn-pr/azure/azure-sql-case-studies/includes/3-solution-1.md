In the previous unit, you worked through a scenario about global scale for a content delivery network. In this unit, you'll review one potential solution and some items to consider.

As you review, you should compare the provided solution to the one that you developed in the previous unit. Often, more than one correct solution exists for any problem, but there are always tradeoffs. Which items in your solution differ from the proposed one? Is there anything in your solution you might rethink? Is there anything in the provided solution that you think is addressed more thoroughly in your solution?  

## Deployment option and configuration

The first decision to consider is which deployment option of Azure SQL you should select. Although SQL Server in an Azure virtual machine (VM) would work, a platform as a service (PaaS) offering might provide a better fit with less management overhead. 

The customer is using the common language runtime (CLR), which is an instance-scoped feature. Azure SQL Managed Instance is the only PaaS deployment option that supports instance-scoped features like CLR, Service Broker, and Database Mail. For this reason, Azure SQL Managed Instance can allow the customer to move to a PaaS offering without having to rewrite its CLR applications into a solution that's compatible with Azure SQL Database (like elastic database jobs).

The next decision to make involves the service tier. Because the customer wants to isolate its read and write workloads, using the Business Critical service tier will be the simplest way to achieve that. The Business Critical service tier has an Always On availability group running behind the scenes. One of those secondary replicas can be used for read-only workloads.

Business Critical is only one half of the configuration here to separate read and write workloads. The scenario states that the customer needs to be able to scale over multiple regions with multiple queries happening at the same time, while isolating read and write workloads. 

The two options that can potentially address this challenge are geo-replication and auto-failover groups. However, geo-replication is not currently supported in Azure SQL Managed Instance. Using an auto-failover group is therefore the only option that can help this scenario in getting global read-scale. 

Because the customer is using auto-failover groups, whether or not it needs the Business Critical service tier will depend on how many read-only endpoints its analytics workload requires. With an auto-failover group in the Business Critical service tier, the customer would get three readable endpoints:

- One secondary replica from the primary region's availability group
- The secondary of the failover group (which is the primary replica of the database in the secondary region)
- The secondary replica from the secondary region's availability group

If the analytics workload does not need all these readable replicas, using General Purpose might be a more cost-effective solution.

## Selecting the most appropriate authentication methods

The other piece of this scenario involves determining the best way for each application or person to connect to the solution, given the need to create and use the most secure technologies possible. If you break down the scenario, four separate clients will need access to Azure SQL Managed Instance:

- Application running on an Azure VM
- Application running on a non-Azure machine
- DBAs or other users of SQL admin tools (SQL Server Management Studio, Azure Data Studio, PowerShell) from a non-Azure machine
- Older applications running on a non-Azure machine where you can't change the driver or connection string

Let's look at these clients in terms of how you might choose the authentication method and some additional considerations and constraints.

### Application running on an Azure VM

Managed identities for Azure resources are, in general, the recommended form of passwordless authentication for applications running on Azure virtual machines.

### Application running on a non-Azure machine

For non-Azure machines, using managed identities is not an option. Integrated authentication via Azure Active Directory (Azure AD) is the recommended authentication method for apps running on domain-joined machines outside Azure, assuming that the domain has been federated with Azure AD. 

Alternatively, you can:

1. Create an application identity for your application in Azure AD.
1. Associate a certificate with the application identity.
1. Modify your application to acquire a token for Azure SQL Database by providing a client ID and a certificate. 

Although the certificate must contain a private key and it must be deployed on the machine that hosts your application, you at least avoid hardcoding an application secret in the application code or configuration. (You'll need to configure the app with the certificate thumbprint.)

### DBAs or other users of SQL admin tools from a non-Azure machine

For users outside Azure, eliminating the use of passwords is best if possible. You can eliminate the use passwords with SQL tools by using Azure AD integrated authentication. The tools must run on a domain-joined machine, and the domain must have been federated with Azure AD. 

If your environment doesn't meet the prerequisites for integrated authentication, we recommend that you use Azure AD interactive authentication with multifactor authentication, which most SQL tools support.

### Older applications running on a non-Azure machine where you can't change the driver or connection string

In scenarios where the driver or connection string can't be changed, an option for eliminating passwords doesn't exist today. These older applications must continue to use SQL authentication. You might consider diving deeper into the restrictions and how they can be lifted in order to use a more secure and safeguarded approach for applications to authenticate.
