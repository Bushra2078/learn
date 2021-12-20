After configuring both sites with VMware SRM, you should proceed with installing the VMware vSphere Replication solution. vSphere Replication is an integrated component of VMware vSphere, and uses a VM replication engine on the hypervisor level.

## vSphere Replication appliance components

vSphere Replication is an Azure VMware Solution private cloud add-on that you can use to help protect your VMs from partial or complete site failure. Any changes to the primary site VM are captured by vSphere Replication and are applied to the VM’s offline disk copies (replicas).

The vSphere Replication appliance provides the following components for the protection scenarios:

- A SRM user interface for working with vSphere Replication.
- A plug-in to the vSphere web client and vSphere client that provides a user interface for vSphere Replication health status.
- A VMware standard embedded PostgreSQL database that stores the replication configuration.
- A vSphere Replication management server that manages replications.
- A vSphere Replication server that provides the core of the vSphere Replication infrastructure.

## Install vSphere Replication appliance 

Use the following procedure to enable the add-on in Azure VMware Solution:

1. Select your Azure VMware Solution. 
2. From the navigation menu in the **Manage section**, select **Add-ons**.
3. On the navigation pane, under **Disaster Recovery**, select **Start**.
4. Go to **Setup replication**. 
5. From the drop-down menu, select **vSphere Replication**.
6. Configure the number of vSphere servers, and then select **Install**.             

:::image type="content"  source="../media/4-avsukwest-add-ons.PNG" alt-text="Screenshot of the Disaster recovery tab in Azure VMware Solution. The vSphere Replication option is selected under Setup replication.":::               

After you set up the replication infrastructure, you can select the VMs to be replicated at a different RPO. You can enable the multiple point-in-time retention policy to store more than one instance of the replicated VM. After recovery, the retained instances are available as snapshots of the recovered VM.

Your sites are now configured and ready for testing and implementing different disaster recovery plans for your VMs.
