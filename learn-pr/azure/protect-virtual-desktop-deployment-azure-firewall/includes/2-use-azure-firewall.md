To prevent any unauthorized network traffic in your Azure Virtual Desktop environment, limit network traffic by using Azure Firewall. In this unit, you'll learn how Azure Firewall filters traffic for Azure Virtual Desktop.

## What is Azure Firewall?

Recall that Azure Firewall is a cloud-based security service that protects your Azure virtual network resources from incoming and outgoing threats. Azure Firewall is provisioned inside a hub virtual network. Traffic to and from the spoke virtual networks and the on-premises network traverses the firewall with the hub network.

All traffic to and from the internet is denied by default. Traffic is only allowed if it passes various tests, such as the configured firewall rules.

:::image type="content" source="../media/2-firewall-description.png" alt-text="Diagram of Azure Firewall in a hub virtual network with traffic to and from the internet passing through the hub network to spoke virtual networks, and an on-premises network." border="false":::

Azure Firewall works not only for traffic to and from the internet, but also internally. Internal traffic filtering includes spoke-to-spoke traffic and hybrid cloud traffic between your on-premises network and your Azure virtual network.

## What is Azure Virtual Desktop?

Azure Virtual Desktop is a desktop and app virtualization service that runs on the cloud. Azure Virtual Desktop works across devices, like Windows, Mac, iOS, Android, and Linux, with apps that you can use to access remote desktops and apps. You can also use most modern browsers to access Azure Virtual Desktop-hosted experiences.

## How does Azure Firewall filters traffic for Azure Virtual Desktop?

When an end user connects to an Azure Virtual Desktop environment, their session is run by a host pool. A host pool is a collection of Azure virtual machines (VMs) that register to Azure Virtual Desktop as session hosts. These VMs run in a Azure virtual network and are subject to virtual network security controls.

For Azure Virtual Desktop to work, the host pool needs outbound internet access to the Azure Virtual Desktop service. The host pool might also need outbound internet access for your users. You can use Azure Firewall to lock down your environment and filter outbound network traffic.

The following diagram shows how traffic for the Azure Virtual Desktop service and host pools is filtered by Azure Firewall.

:::image type="content" source="../media/2-firewall-azure-virtual-desktop-architecture.png" alt-text="Diagram of Azure Firewall filtering network traffic between the Azure Virtual Network service and the host pool virtual network." border="false":::

The following table explains the labels in the illustration.

|Label  |Description  |
|---------|---------|
|A     |The host pool's outbound network access to the Azure Virtual Desktop service is filtered by Azure Firewall.      |
|B     |Application and network firewall rules, and threat intelligence filter user outbound access from the host pool virtual network.      |
|C     |Traffic is filtered from the firewall to on-premises. Azure Firewall can also send user traffic to an on-premises proxy.        |
