Azure ExpressRoute allows an organization like Adatum to connect their on-premises networks directly into the Microsoft Azure and Microsoft 365 clouds. Azure ExpressRoute uses a dedicated high bandwidth connection provided by a Microsoft partner. This dedicated high bandwidth connection does not pass across the public internet in the manner that a VPN connection to Azure does. Connections come with a dedicated service level agreement that ensures uptime and bandwidth are always available. Microsoft guarantees a minimum of 99.95% availability for ExpressRoute dedicated connections. As the connection is private and only travels between on-premises and Azure over a dedicated line, traffic cannot be intercepted by third parties as it crosses the public internet. 
  
:::image type="content" source="../images/expressroute-structure.png" alt-text="Diagram that shows the structure of Azure ExpressRoute.":::

ExpressRoute provides direct access between on-premises networks and the following services:

- Azure compute services (Azure IaaS Virtual Machines, Azure Kubernetes Services)
- Azure cloud Services (Azure Files, Azure Storage, Azure SQL)
- Microsoft Office 365
- Microsoft Dynamics 365

ExpressRoute provides organizations with Open Systems Interconnection (OSI) model Layer 3 connectivity between hosts on-premises and hosts in Microsoft’s cloud. For example, a computer on your on-premises network can use an ExpressRoute connection to contact an IaaS VM through its IP Address, but cannot send traffic to that IaaS VM’s MAC (Media Access Control) address.

ExpressRoute providers provision connections with redundant devices. Service Level Agreements (SLAs) guarantee a high level of availability. Organizations who require availability guarantees beyond that offered by the provider SLA can configure multiple ExpressRoute connections.

## ExpressRoute Global Reach

ExpressRoute Global Reach allows organizations with multiple on-premises locations connected to Azure ExpressRoute to route traffic between those on-premises locations across the Azure global network backbone. For example, if Adatum has an on-premises location in Sydney connected to ExpressRoute and an on-premises location in London connected to ExpressRoute, traffic between host on the Sydney and London networks could be configured to pass across those ExpressRoute connections and through the Azure global network backbone rather than via another path.

## ExpressRoute connectivity models

Azure ExpressRoute supports three models for connecting on-premises networks to Microsoft’s clouds. These are: 

- Point-to-point Ethernet connection. This connectivity model provides direct Layer 2 and Layer 3 connectivity between an organization’s on-premises network and Microsoft’s clouds. For example, if Adatum implemented this model, any host connected to your on-premises network that interacts with an Azure resource such as an IaaS VM or an Azure File Share would have the network traffic for that interaction travel across the ExpressRoute connection.
- CloudExchange co-location. Co-located providers supply Layer 2 and Layer 3 connections between infrastructure at a co-location facility and the Microsoft cloud. For example, if your organization had servers hosted at a co-location facility, co-location at a cloud exchange allows you to connect from that facility to Microsoft’s clouds.
- Any-to-any (IPVPN) connection. In this model, you can integrate your organization’s Wide Area Network (WAN) connection with Microsoft Azure. The ExpressRoute connection to Microsoft’s clouds will function as another location on your organization’s private WAN.
- Direct Model. You can connect directly at a Microsoft peering location rather than connecting through a service provider who connects you through to the Microsoft clouds. ExpressRoute Direct provides dual 100 Gbps or 10-GbPs connectivity.

:::image type="content" source="../images/expressroute-connectivity-models.png" alt-text="Diagram that depicts the types of connections Azure ExpressRoute supports.":::

## ExpressRoute security

ExpressRoute uses a private connection between your on-premises network and Microsoft’s clouds. VPN connections travel across the public internet so it is possible (if unlikely) that traffic can be captured as it passes across the internet. Some jurisdictions require that certain types of data never transit the public internet so choosing ExpressRoute is a matter of compliance rather than simple technical necessity.  

> [!NOTE]
> Even if an ExpressRoute connection is used, DNS queries, certificate revocation list checking, and requests to the Azure Content Delivery Network will still be sent across the public internet.
