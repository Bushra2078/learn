Azure Private Link provides access to Azure services privately over the Microsoft Azure backbone network instead of publicly over the internet.

Suppose you work at Contoso, Ltd., a financial services company in Seattle with major offices located throughout the world. Your company has an Azure virtual network that connects to several Azure PaaS services. Your company also connects to these Azure PaaS services via several peered virtual networks and an on-premises network that uses Azure ExpressRoute. Contoso also offers company-created Azure services that Contoso customers connect to from their own Azure virtual networks.

However, Contoso IT staff are concerned that all of these connections require the public internet, which they consider a security risk. IT would like these connections to not use a public IP address.

You're a network engineer at Contoso. You’re responsible for finding a way to enable employees and customers to privately access services on the Azure platform. In particular, you want to evaluate Azure Private Link as a method for bypassing the internet and offering private connections.

In this module, you'll learn the fundamentals of Azure Private Link. You'll learn what it is, how it works, and when you should use it. By the end of this module, you'll be able to evaluate whether Azure Private Link is a suitable solution for offering Contoso employees and customers private access to Azure services.

## Learning objectives

In this module, you will:

- Explain how Azure Private Link, Azure Private Endpoint, and Azure Private Link Service work together to create private connections to Azure resources.
- Evaluate whether Azure Private Link is appropriate for giving your employees, vendors, and customers private access to your Azure services.
- Identify and describe use cases for Azure Private Link.

## Prerequisites

To get the best learning experience from this module, you should have:

- Beginner-level knowledge of Azure, including regions, Azure virtual networks, Azure Virtual Network Peering, Azure Active Directory, and ExpressRoute.
- Beginner-level knowledge of networking, including IP addresses, full qualified domain names (FQDNs), network interfaces, and virtual private networks.
<!-- Replace "full" with "fully". FQDN stands for Fully Qualified Domain Name. -->
- Beginner-level knowledge of cloud computing, including tenants, virtual networks, virtual machines, and platform as a service (PaaS).
