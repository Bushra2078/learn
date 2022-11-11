You've learned what Azure Private 5G Core is and the role it plays in Azure private MEC solutions. Now let's see how Azure Private 5G Core provides the 5G network functions and manages the private network. 

This unit introduces the key components and the packet core architecture of Azure Private 5G Core. In addition, it also lists the Azure resources that you'll use to manage your private mobile network.

## Key components

The following diagram shows the key components of Azure Private 5G Core:

:::image type="content" source="../media/azure-private-5g-core-components.png" alt-text="A diagram that shows the components of Azure Private 5G Core" border="true":::

The diagram uses different colors to indicate the on-cloud components and the on-premises components.

- On-cloud components: The on-cloud components allow you to centrally manage sites in a private mobile network.
  - Portal: The Azure portal with which you can manage sites at different geographical locations.
  - Resource Manager APIs: The Resource Manager APIs allow enterprise private mobile network and its sites to be managed from Azure.
  - Monitor: The monitor component allows you to monitor the health of the private network and the UEs in it.
  - SIM Manager: The SIM manager allows you to manage the SIMs in the UEs and relevant SIM groups from Azure.
  - Service Manager: The service manager allows you to configure and manage the network functions that Azure Private 5G Core provides.
  - RAN Monitor: The RAN monitor allows you to monitor the RAN that your private network uses.
- On-premises components: The on-premises components provide 5G and 4G network functions in a private mobile network.
  - 5G Core Control Plane and 5G Control Plane: The 5G components provide 5G network functions for your private mobile network.
  - 4G Interworking Function: This component allows you to use 4G network functions in your private mobile network.
  - Subscriber database and policy control: This component provides support for the information and policy management of the UEs in the private mobile network.
  - Arc managed Azure Kubernetes Service: This service hosts the packet core instance that Azure Private 5G Core deploys for each site. It also connects all the sites in an enterprise.
  - Azure Stack Edge: ASE is the edge device in the enterprise. It provides the underlying platform that hosts Azure Private 5G Core.

## Packet core architecture

Azure Private 5G Core instantiates a single private mobile network distributed across one or more enterprise sites across the world. Each site contains a packet core instance, which is a cloud-native implementation of the 3GPP standards-defined 5G Next Generation Core. A packet core instance authenticates end devices and aggregates their data traffic over 5G standalone wireless and access technologies.

Each packet core instance is connected to the local RAN network to provide coverage for cellular wireless devices. You can choose to limit these devices to local connectivity. Alternatively, you can provide multiple routes to the cloud, internet, or other enterprise data centers running IoT and automation applications.

Each packet core instance includes the following components:

- A high performance (25 Gbps rated load) and highly programmable 5G User Plane Function (UPF).
- Core control plane functions including policy and subscriber management.
- A portfolio of service-based architecture elements.
- Management components for network monitoring.

You can also deploy packet core instances in 4G mode to support Private Long-Term Evolution (LTE) use cases. For example, you can use the 4G Citizens Broadband Radio Service (CBRS) spectrum. 4G mode uses the same cloud-native components as 5G mode (such as the UPF). This is in contrast to other solutions that need to revert to a legacy 4G stack.

## Azure resources

The following diagram shows the key Azure resources that you'll use to manage your private mobile network.

:::image type="content" source="../media/private-5g-core-resources.png" alt-text="A diagram that displays the resources you'll use to manage your private mobile network" border="true":::

- Each *SIM* resource represents a physical SIM or an eSIM. The UEs hosted by the private network use the SIMs to communicate with the network. You can use *SIM group* resources to categorize SIMs for easier management. Each SIM must be a member of a SIM group, but can't be a member of more than one.
- The *SIM policy* resources are for control policy customization. You can use SIM policies to implement flexible traffic handling. Each SIM policy defines a set of policies and interoperability settings. You'll need to assign a SIM policy to a SIM before the UE using that SIM can access the private mobile network.
- The *mobile network site* and *packet core* resources allow you to manage the sites in your private mobile network and the packet core instances that run in them.
- Each *attached data network* resource allows you to manage how its associated packet core instance will connect to the data network.
