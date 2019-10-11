Azure Security Center monitors the status of antimalware protection for your VMs. Security Center notes issues, such as detected threats and insufficient protection, that might make your VMs and computers vulnerable to malware threats. By using the information on **Endpoint protection issues**, you can make a plan to address any identified issues.

1. Open the Security Center overview page - you can select the **Home** button from the left-hand sidebar and then **Security Center** from the dashboard, or use the search function to quickly navigate to Security Center.

1. Select the **Compute & apps** section under **RESOURCE SECURITY HYGIENE**.

1. You can either find the **Install endpoint protection solution on virtual machines** entry in the Overview, or filter your view to **VMs and Computers** where you can see recommendations based on the virtual machines.

Security Center reports the following endpoint protection issues:

- **Endpoint protection not installed on Azure VMs** - A supported antimalware solution isn't installed on these Azure VMs.

- **Endpoint protection not installed on non-Azure computers** -  A supported antimalware solution isn't installed on these non-Azure computers.

- **Endpoint protection health issues**:

  - *Signature out of date*. An antimalware solution is installed on these VMs and computers, but the solution doesn't have the latest antimalware signatures.

  - *No real-time protection*. An antimalware solution is installed on these VMs and computers, but it isn't configured for real-time protection. The service might be disabled, or Security Center might be unable to obtain the status because the solution isn't supported.

  - *Not reporting*. An antimalware solution is installed but not reporting data.

  - *Unknown*. An antimalware solution is installed, but either its status is unknown, or it's reporting an unknown error.

For VMs which are vulnerable, Security Center will offer to resolve the issue and install malware protection onto the unprotected VMs.

![Screenshot showing the Install on VMs option from ASC](../media/5-install-malware-from-asc.png)

However, you can also install this protection yourself. Let's examine those steps.

## Install Antimalware onto a new VM

**Microsoft Antimalware** is available as an extension that you can add to existing VMs, or include as part of the creation of a new VM. You can use the Azure portal, Azure CLI / Powershell, or ARM template to add the extension.

Let's use the Azure portal to create a new VM and install the extension.

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true) with the same account and subscription you used in the previous exercise. We'll reuse the same resource group so we can delete both VMs at the same time.

1. Select **Create a resource** from the left sidebar.

1. Select **Windows Server 2016 Datacenter** from the quick picklist.

1. Fill out the **Basics** tab with the following information.
    - **Subscription**: select your subscription.
    - **Resource group**: select the resource group you created earlier (**mslearnDeleteMe**) from the drop-down list.
    - **Virtual machine name**: enter a VM name such as _testvm1_.
    - **Region**: select a region such as _East US_.
    - **Username**: select a valid username you will remember.
    - **Password**: select a valid password you will remember.

    ![Screenshot showing the Basic tab for VM creation](../media/7-create-vm.png)

1. Select the **Advanced** tab. Here you can add extensions to the new VM. Click the **Select an extension to install** and use the search box to locate **Microsoft Antimalware** and select **Create** to add it to the VM.

1. The options for the extension include the ability to ignore specific folders, filenames, and control when and how the extension scans the disk for malware. You can leave the default options in place.

    ![Screenshot showing the default options for Microsoft malware](../media/7-install-ms-malware.png)

1. Select **OK** to move back to the **Advanced** tab and note that the malware extension is set to install.

    ![Screenshot showing the Advanced tab with Microsoft malware extension installed](../media/7-install-ms-malware2.png)

1. Next, select the **Management** tab. This is where you can configure the monitoring capabilities for Azure Security Center.
    - Detailed monitoring which can be viewed in Azure Monitor.
    - Boot diagnostics
    - OS guest diagnostics

    If any of these options are selected, the VM will need an Azure Storage account to write the log data.

1. Check the **Diagnostic storage account** entry. Depending on the location you selected for the VM, Azure will select an existing storage account, _or_ show an error if no storage account is available.

1. Create a new storage account if necessary. It will be placed in the same resource group as the VM.

    ![Screenshot showing the diagnostic options in the VM creation portal](../media/5-set-storage-account.png)

1. Select **Review + Create**, verify the settings, and select **Create** to deploy the new VM.

This will take a few minutes to complete - you can monitor the deployment through the **Notifications** (bell icon) view, or by clicking on the deployment message. While it deploys, let's examine how you'd add malware protection to an _existing_ VM.

## Adding the extension to an existing VM

You can also add the antimalware extension to an existing VM after it's deployed. This can be done with command-line tools (so it can be scripted), using the REST APIs, or through the Azure portal. Here's the steps you'd use for the portal:

1. First, select the VM you want to install the extension on.
1. Select the **Extensions** section under **Settings**.

    ![Screenshot showing the Add Extension option](../media/7-install-ms-malware3.png)

1. Locate **Microsoft Antimalware** in the presented list, and select **Create** on the details screen to add the extension to your VM. The same extension options you used during VM creation are available here.

1. Once it's installed (it will take a few minutes), the extensions pane will update and show the malware extension.

    ![Screenshot showing the MS Malware extension installed into the VM](../media/7-install-ms-malware4.png)
