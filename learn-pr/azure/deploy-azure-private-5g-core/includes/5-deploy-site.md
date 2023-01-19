This section includes:

- The prerequisites for creating a site.
- The deployment procedure for creating a site.

## Prerequisites for creating a site

Before creating a site, perform the following:

1. To begin with, collect the required information for a site. Refer to [Collect information for a site - Azure Private 5G Core Preview](/azure/private-5g-core/collect-required-information-for-a-site).
1. Refer to the release notes for the current version of packet core, and whether it's supported by the version your Azure Stack Edge (ASE) is currently running. If your ASE version is incompatible with the latest packet core, [update your Azure Stack Edge Pro GPU](/azure/databox-online/azure-stack-edge-gpu-install-update).
1. Log in to the Azure portal using your account to access the active subscription you used to create your private mobile network. This account must have the built-in contributor or owner role at the subscription level.
1. Configure custom location for AKS cluster: To configure ASE and to create an AKS cluster on the ASE using Azure portal, refer to [Azure Stack Edge documentation](/azure/databox-online/).
1. Sign in to the  [Azure portal](https://portal.azure.com/) to create the mobile network site resource representing the physical enterprise location of your Azure Stack Edge device, which will host the packet core instance.

## Create a site for deployment

You can add a new site to an existing mobile network then configure ASE later.

If you have ASE pre-configured, it takes a few hours to deploy a site.

When you deploy a site, the following are deployed automatically:

- **Packet Core** - Each site contains an instance of a 5G packet core (5GC), which connects your 4G or 5G devices to the upstream network and manages the traffic flows between them.
- **Troubleshooting tools (distributed tracing and local monitoring** **tool)**  - Each site deployment includes powerful tools to help local administrators monitor and diagnose the system in their site.
  1. Search for and select the **Mobile** **Network resource** representing the private mobile network to which you want to add a site.
     :::image type="content" source="../media/mobile-network-selection.png" alt-text="select-mobile-network":::
  1. On the **Get started** tab, select **Create sites**.
  1. Use the information you collected in [Collect site resource values](/azure/private-5g-core/collect-required-information-for-a-site) to fill out the fields on the **Basics** configuration tab, and then select **Next: Packet core >**.
     :::image type="content" source="../media/basics-config-site.png" alt-text="basics-configuration-tab-site":::
  1. You'll now see the **Packet core** configuration tab.
     :::image type="content" source="../media/packet-core-config.png" alt-text="packet-core-configuration":::
  1. In the **Packet core** section, set the fields as follows:
     - If you're configuring your packet core to have more than one attached data network, leave the **Custom location** field blank. You'll configure this field at the end of this procedure.
     - Use the information you collected in [Collect packet core configuration values](/azure/private-5g-core/collect-required-information-for-a-site) to fill out the **Technology type**, **Azure Stack Edge device**, and **Custom location** fields.
     - Select the recommended packet core version in the **Version** field.
     - Ensure **AKS-HCI** is selected in the **Platform** field.
     - Use the information you collected in [Collect access network values](/azure/private-5g-core/collect-required-information-for-a-site) to fill out the fields in the **Access network** section. 
  1. In the **Attached data networks** section, select **Attach data network**. Select whether you want to use an existing data network or create a new one, then use the information you collected in [Collect data network values](/azure/private-5g-core/collect-required-information-for-a-site) to fill out the fields. Once you've finished filling out the fields, select **Attach**.
     :::image type="content" source="../media/attach-data-networks.png" alt-text="This screen displays the attach data networks section in the site creation page.":::
  1. Repeat the previous step for each additional data network you want to configure. 
  1. If you chose to provide a custom HTTPS certificate in [Collect local monitoring values](/azure/private-5g-core/collect-required-information-for-a-site), select **Next : Local access >**. If you are not providing a custom HTTPS certificate at this stage, you can skip this step. Under **Provide custom HTTPS** **certificate?** select **Yes**.
     :::image type="content" source="../media/local-access.png" alt-text="This screen displays the local access section in the site creation page.":::
     Use the information you collected in [Collect local monitoring values](/azure/private-5g-core/collect-required-information-for-a-site) to select a certificate.

     Access to the distributed tracing and packet core dashboards is secured by HTTPS. You can use a self-signed certificate or provide your own to authenticate access to your local diagnostics tools. We recommend providing a certificate signed by a globally known and trusted certificate authority (CA) for additional security in your deployment.
  1. Select **Submit**.
  1. Select **Review + create**.
  1. Azure will now validate the configuration values you've entered. You should see a message indicating that your values have passed validation.
     :::image type="content" source="../media/validation-site.png" alt-text="This screen displays the site validation complete message.":::
  1. Once your configuration has been validated, you can select **Create** to create the site. The Azure portal displays the following confirmation screen when the site is created.  This process may take a few minutes based on factors such as the region selected, the edge location, and the internet access speed.
     :::image type="content" source="../media/site-deployment-complete.png" alt-text="This image provides the details on the successful site deployment.":::

Select **Go to resource group**, and confirm that the resource group contains the following new resources:

    -  A Mobile Network Site resource representing the site.
    -  A Packet Core Control Plane resource representing the control plane function of the packet core instance in the site.
    -  A Packet Core Data Plane resource representing the data plane function of the packet core instance in the site. 
    -  One or more Data Network resources representing the data networks (if you chose to create new data networks). 
    -  One or more Attached Data Network resources providing configuration for the packet core instance's connection to the data networks.
  
If you have not yet set the **Custom location** field, set it now. From the resource group overview, select **the Packet Core Control Plane resource** and **select Configure a custom location**. Use the information you collected in [Collect packet core configuration values](/azure/private-5g-core/collect-required-information-for-a-site) to fill out the **Custom location** field and select **Modify**.

If you wish to delete one or more sites created, refer to [Delete sites - Azure Private 5G Core](/azure/private-5g-core/delete-a-site).
To modify or upgrade a packet core instance, refer to [Modify a packet core instance - Azure Private 5G Core](/azure/private-5g-core/modify-packet-core).

## **Configure a service and SIM policies using Azure portal**

Services are representations of a particular set of QoS information that you want to offer to UEs. For example, you may want to configure a service that provides higher bandwidth limits for specific traffic. 

You can also use services to block specific traffic types or traffic from specific sources. For more information, see [Policy control](/azure/private-5g-core/policy-control).

For instructions on configuring a service and SIM policies, refer to [Management module](/training/modules/manage-azure-private-5g-core/?branch=pr-en-us-31182).

To get instructions on how to configure SIM policies using Azure portal, refer to [Configure a SIM policy - Azure Private 5G Core](/azure/private-5g-core/configure-sim-policy-azure-portal).

> [!NOTE]
> Provisioning SIM and SIM policies can be done as part of deployment, however, the preferred way is to select **No** and complete these tasks as part of Managing the Azure Private 5G Core networks.
> For more information, see [Management module](/training/modules/manage-azure-private-5g-core/?branch=pr-en-us-31182).
