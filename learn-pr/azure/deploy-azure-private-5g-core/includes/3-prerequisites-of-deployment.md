Before you create a private mobile network, you need to complete following prerequisites or tasks:
- **Order and set up your Azure Stack Edge Pro device(s):** You need to order the ASE device, ensuring that you follow the [checklist](/azure/databox-online/azure-stack-edge-gpu-deploy-checklist?pivots=single-node) and register the ASE device in the Azure cloud. 
For additional ASE configuration, see [Prepare to deploy a private mobile network - Azure Private 5G Core Preview | Microsoft Learn](/azure/private-5g-core/complete-private-mobile-network-prerequisites).
- **Create Subscription**: The customers or partners must follow the standard Azure procedure to [create a subscription](/azure/cost-management-billing/manage/create-subscription). Customers or partners should have owner or contributor access to Azure subscription. In the **Azure portal**, go to **Home > Subscriptions > Your-subscription > Resource providers**.
Register the Mobile Network resource provider (Microsoft.MobileNetwork) for your subscription, as described in [Azure resource providers and types](/azure/azure-resource-manager/management/resource-providers-and-types). 

  > [!NOTE]
  >  Single subscription can be used for multiple mobile networks (For example: each in their own resource group). 

- **Choose the packet core type**:  Each site in the private mobile network should provide coverage for 5G or 4G user equipment (UEs). 

  > [!Note]
  >  Azure Private 5G Core connects with any standard 5G standalone radios over standard N1/N2/N3 interfaces. The 5G core network functions comply with 3GPP specifications. 

- **Allocate Subnet and IP addresses**: Azure Private 5G Core requires a management network, access network, and one or more data networks. These networks are part of the same, larger network, or they can be separate. The approach you use depends on your traffic separation requirements. 
For each of these networks, allocate a subnet and then identify the listed IP addresses. If you're deploying multiple sites, you'll need to collect this information for each site. 
- **Allocate user equipment (UE) IP address pools**:  Azure Private 5G Core supports the following IP address allocation methods for UEs- 
  - Dynamic. Dynamic IP address allocation automatically assigns a new IP address to a UE each time it connects to the private mobile network. 
  - Static. Static IP address allocation ensures that a UE receives the same IP address every time it connects to the private mobile network. This is useful when you want Internet of Things (IoT) applications to be able to consistently connect to the same device. For example, you may configure a video analysis application with the IP addresses of the cameras providing video streams. If these cameras have static IP addresses, you won't need to reconfigure the video analysis application with new IP addresses each time the cameras restart. You'll allocate static IP addresses to a UE as part of [provisioning its SIM](/azure/private-5g-core/provision-sims-azure-portal). 
- **Configure Domain Name System (DNS) servers**:  DNS allows the translation between human-readable domain names and their associated machine-readable IP addresses.  

  > [!Note]
  > If you don't configure DNS servers for a data network, all UEs using that network will be unable to resolve domain names. 

Depending on your requirements, you have the following options for configuring a DNS server for your data network: 

- If you need the UEs connected to this data network to resolve domain names, you must configure one or more DNS servers. You must use a private DNS server if you need DNS resolution of internal hostnames. If you're only providing internet access to public DNS names, you can use a public or private DNS server. 
- If you don't need the UEs to perform DNS resolution, or if all UEs in the network will use their own locally configured DNS servers (instead of the DNS servers signalled to them by the packet core), you can omit this configuration. 
- **Set up the ports required for local access**: Setup the ports you need to open for Azure Private 5G Core local access. This includes local management access and control plane signalling. Please make sure to open the following ports to allow the inbound traffic from the remote access VM to the ASE local UI, AP5GC AKS cluster and Grafana dashboard. 

To ensure successful connectivity of all the ASE and AP5GC infrastructure to Azure services, we recommend configuring a firewall to allow all the outbound traffic.

In the case where you do not want to allow all the outbound traffic, they will have to configure the firewall with Azure services specific IP addresses and the URLs. Please contact Microsoft Support to obtain the list of Azure services specific IP address and URL details.

You should set these up in addition to the [ports required for Azure Stack Edge (ASE)](/azure/databox-online/azure-stack-edge-gpu-system-requirements).

In addition to the 5G core software, you'll need to purchase the following to complete your solution: 

- SIMs and RANs: The ecosystem of trusted Private 5G Core partners can provide you with these components. 
- Azure Stack Edge Pro SKU: You'll need to purchase this Microsoft hardware through Azure.

Once you are ready for the deployment, you can use the Azure portal for the following deployment tasks:

1. Create a private mobile network.
1. Create a site.
1. Configure service and SIM policy.
