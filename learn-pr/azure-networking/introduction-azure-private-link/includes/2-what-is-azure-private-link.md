Before you learn about Azure Private Link and its features and benefits, let's have a quick look at the problem that Private Link is designed to solve.

Suppose your company has an Azure virtual network and you want to connect to a PaaS resource such as an Azure SQL Database. When you create the SQL database resource, you normally specify a *public endpoint* as the connectivity method.

Having a public endpoint means that the resource is assigned a public IP address. So, even though both your virtual network and the SQL database are located within the Azure cloud, the connection between them takes place over the internet.

The problem is that your SQL database is exposed to the internet via its public IP address. That exposure creates multiple security risks. The same security risks are present when an Azure resource is accessed via a public IP address from the following locations:

* A peered Azure virtual network.
* An on-premises network that connects to Azure using ExpressRoute and Microsoft peering.
* A customer's Azure virtual network that connects to an Azure service offered by your company.

<!-- insert image here -->

Private Link is designed to eliminate these security risks by removing the "public" part of the connection.

## Overview of Private Link

Private Link provides secure access to Azure services. Private Link achieves that security by replacing a resource's public endpoint with a private network interface. There are three key points to consider with this new architecture:

* The Azure resource becomes, in a sense, a part of your virtual network.
* The connection to the resource now uses the Microsoft Azure backbone network instead of the public internet.
* You can configure the Azure resource to no longer expose its public IP address, which eliminates that potential security risk.

<!-- insert video here -->

## What is Azure Private Endpoint?

Private Endpoint is the key technology behind Private Link. Private Endpoint is a network interface that enables a private and secure connection between your virtual network and an Azure service. In other words, Private Endpoint is the network interface that replaces the resource's public endpoint.

> [!NOTE]
> Private Endpoint is not a free service. You pay a set fee per hour, as well as a set fee per gigabyte for both inbound and outbound traffic that passes through the Private Endpoint.

## What is Azure Private Link Service?

Private Link gives you private access from your Azure virtual network to PaaS services and Microsoft Partner services in Azure. However, what if your company has created its own Azure services that are consumed by your company's customers? Is it possible to offer those customers a private connection to your company's services?

Yes, by using Azure Private Link Service. This service lets you offer Private Link connections to your custom Azure services. Consumers of your custom services can then access those services privately—that is, without using the internet—from their own Azure virtual networks.

> [!NOTE]
> There is no charge to use Private Link Service.

## Key benefits of Private Link

Private Link working together with Private Endpoint and Private Link Service provides the following benefits:

* Private access to PaaS services and Microsoft Partner services on Azure. Using Private Endpoint, Azure services are mapped to your Azure virtual network. It doesn't matter that the Azure resource is in a different virtual network and in a different Active Directory tenant. To users in your Azure virtual network the resource appears to be part of that network.
* Private access to Azure services in any region. Private Link works globally. The private connection to an Azure service works even if that service's virtual network is in a different region than your own virtual network.
* Non-public routes to Azure services. Once an Azure service has been mapped to your virtual network, the traffic route changes. All inbound and outbound traffic between your virtual network and the Azure service goes over the Microsoft Azure backbone network. The public internet is never used for service traffic.
* Public endpoints are no longer required. Since all traffic to and from a mapped Azure service now flows over the Microsoft Azure backbone, the public endpoint for the service is no longer required. You can disable that public endpoint and therefore eliminate a possible security threat.
* Your peered Azure virtual networks also get access to Private Link-powered resources. If you have one or more peered Azure virtual networks, no extra configuration is needed for those peered networks to access a private Azure resource. Clients within any peered network can access whatever Private Endpoint you've mapped to an Azure service.
* Your on-premises network also gets access to Private Link-powered resources. Does your on-premises network connect to your Azure virtual network using either ExpressRoute private peering or a VPN tunnel? If so, no extra configuration is needed for clients within the on-premises network to access a private Azure resource.
* Protection against data exfiltration. When you map a Private Endpoint to an Azure service, you map to a specific instance of that service. For example, if you're setting up private access to Azure Storage, you map the access to a blob, table, or other storage instance. If a virtual machine in your network gets compromised, the attacker can't move or copy data to another resource instance.
* Private access to your own Azure services. You can implement Private Link Service and offer customers private access to your custom Azure services.

## Private Link Availability

Private Link and Private Endpoint work with many Azure services, including those in the following list:

Service| Available regions
--------|----------------
Azure Automation | All public regions
Azure App Configuration | All public regions
Azure Backup | All public regions, all government regions
Azure Batch | All public regions except: Germany Central, Germany Northeast, all government regions
Azure Blob storage | All public regions, all government regions
Azure Container Registry | All public regions, all government regions
Azure Cosmos DB | All public regions, all government regions, all China regions
Azure Data Factory | All public regions, all government regions, all China regions
Azure Database for PostgreSQL | All public regions, all government regions, all China regions
Azure Database for MySQL | All public regions, all government regions, all China regions
Azure Database for MariaDB | All public regions, all government regions, all China regions
Azure Event Grid | All public regions, all government regions
Azure Event Hub | All public regions, all government regions
Azure Files | All public regions, all government regions
Azure File Sync | All public regions
Azure IoT Hub | All public regions
Azure Key Vault | All public regions, all government regions
Azure Kubernetes Service | All public regions
Azure Machine Learning | All public regions
Azure Managed Disks | All public regions, all government regions, all China regions
Azure Monitor | All public regions
Azure Queue storage | All public regions, all government regions
Azure Relay | All public regions
Azure Search | All public regions, all government regions
Azure Service Bus | All public regions, all government regions
Azure SQL Database | All public regions, all government regions, all China regions
Azure Synapse Analytics | All public regions, all government regions
Azure Table storage | All public regions, all government regions
Azure Web Apps | All public regions
Azure SignalR | East US, South Central US, West US 2, all China regions

> [!NOTE]
> Microsoft is gradually rolling out Private Link and Private Endpoint to its services and regions. To keep up to date on the latest services and regions that support Private Link, see [https://azure.microsoft.com/updates/?product=private-link](https://azure.microsoft.com/updates/?product=private-link)