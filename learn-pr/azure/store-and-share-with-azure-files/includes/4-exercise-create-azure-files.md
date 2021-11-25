Azure storage accounts enable organizations to replicate their on-premises file shares in a secure, resilient cloud service. A company can create one or more Azure storage accounts, replicate specific content, and then remove redundant hardware and infrastructure that support the internal SANs and NAS. Importantly, a company can reduce the risk of files being unavailable in the event of a hardware failure.

Your finance company has asked you to duplicate two on-premises file shares, one for reports and the other for application data. The storage account you create needs to be resilient to datacenter failures. Therefore, you'll create a storage account that uses GRS redundancy.

In this exercise, you'll create a new storage account and two file shares for reports and application data. You'll then create a Windows VM to use as your example customer machine. You'll use the VM to mount drives where you can access the file shares. Finally, you'll map two drives to the new Azure file shares and copy reports to them.

## Create a GRS storage account

1. Create a storage account by copying the following Azure CLI commands and pasting them into Azure Cloud Shell on the right.

    ```azurecli
    export STORAGEACCT=learnazurefileshare$RANDOM

    az storage account create \
        --name $STORAGEACCT \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --sku Standard_GRS
    ```

1. Copy and paste this Azure CLI command to save the storage account key in a local variable.

    ```azurecli
    STORAGEKEY=$(az storage account keys list \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --account-name $STORAGEACCT \
        --query "[0].value" | tr -d '"')
    ```

## Create file shares

1. Copy and paste this command to create a file share to store the finance company's reports. This command returns a `created` status.

    ```azurecli
    az storage share create \
        --account-name $STORAGEACCT \
        --account-key $STORAGEKEY \
        --name "reports"
    ```

1. Copy and paste this command to create a file share to store the finance company's application data. This command returns a `created` status.

    ```azurecli
    az storage share create \
        --account-name $STORAGEACCT \
        --account-key $STORAGEKEY \
        --name "data"
    ```

## Create a VM and connect with RDP protocol

Create a Windows Server VM to simulate an on-premises machine running in the finance company's datacenter or branch office.

1. Using Cloud Shell, create a Windows VM with the Azure CLI. When you're prompted for a password, enter a complex password of your choice and note it for reference later.

    ```azurecli
    az vm create \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name 2019FileServer \
        --image Win2019Datacenter \
        --admin-username azureuser
    ```

1. When the virtual machine has been created, sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account you used to activate the sandbox.

1. From the resource menu or on the home page, under **All services**, select **Virtual machines**, and then select the **2019FileServer** VM you created in step 1 of this task. The Overview pane for **2019 FileServer** Virtual machine appears.

1. On the command bar, select **Connect** > **RDP**, and then select **Download RDP File**.

1. When the RDP file has downloaded, select it to run. In the **Remote Desktop Connection** dialog box, select **Connect**.

1. On the Windows Security **Enter your credentials** dialog box, select **More choices**, and then scroll down and select **Use a different account**. In the **Email address** field, enter *azureuser*, in the **Password** field, enter the password you created earlier, and then select **OK**.

    > [!NOTE]
    > If you forgot the password, go oto the VM (2019Fileserver) and select **Reset password** under **Help + support > Help** and then select Update in the command bar to update. Restart this task at step 3 to connect and download the RDP file. Alternatively, restart this task. If you encounter any issues, check the sandbox--if it is not still activated, you've lost the resources necessary to complete this exercise.

1. If you're prompted to verify the remote connection, select **Yes**.

## Map drives to the Azure file shares

1. In the Azure portal, in the global search bar at the top of the page, search for and select **Storage accounts**.

1. Select the storage account that you created earlier; look for a storage account named **learnazurefileshare** followed by random numbers. The storage account pane appears.

1. In the Storage account menu, under **Data storage**, select **File shares**.

    :::image type="content" source="../media/4-select-file-shares.png" alt-text="Screenshot of storage account menu with file shares highlighted." lightbox="../media/4-select-file-shares.png":::

    The **File shares** pane for your storage account appears with two file shares.

1. In the file shares list, select **data**. The **data** file share pane appears.

    :::image type="content" source="../media/4-select-data.png" alt-text="Screenshot of the file shares in the storage account." lightbox="../media/4-select-data.png":::

1. In the command bar, select **Connect**. The **Connect** pane appears.

1. In the **Drive letter** dropdown list, select the **F**.

1. Under **Authentication method**, ensure **Storage account key** is selected, and then copy the PowerShell script that appears in the text box.

    :::image type="content" source="../media/4-connect-share.png" alt-text="Screenshot of the data file share and its connection commands." lightbox="../media/4-connect-share.png":::

1. On your virtual machine, in the system tray, select **Start**, scroll to **Windows PowerShell (Admin)**, or if you don't see **(Admin)**, then right-click **Windows PowerShell** and select **Run as Administrator**.

    :::image type="content" source="../media/4-connect-powershell-admin.png" alt-text="Screenshot of the Windows virtual machine showing Start menu with Windows PowerShell (Admin) selected." lightbox="../media/4-connect-powershell-admin.png":::

1. In the PowerShell console, right-click the PowerShell icon in the title bar, and select **Properties**. 
 
1. On the **Options** tab, ensure that **Use Ctrl+Shift+C/V as Copy/Paste** is selected, and then select **OK**. Now you can use accelerator keys <kbd>Ctrl+Shift+V</kbd> to paste copied content into your VM PowerShell console.

1. At the command prompt, paste the script you copied from the Azure portal, and press <kbd>Enter</kbd>. 

   The system responds with confirmation the CMDKEY credential added successfully, and drive F is has been set up as a fileshare.

1. In the Azure portal, go back to the **File shares** pane for your storage account, and select **reports**.

    :::image type="content" source="../media/4-navigate-back.png" alt-text="Screenshot of how to go back to the file shares." lightbox="../media/4-navigate-back.png":::

1. On the command bar, select **Connect**. The **Connect** reports pane appears.

1. In the **Drive letter** dropdown list, select **G**.

1. Under **Authentication method**, ensure **Storage account key** is selected, and then copy the PowerShell script that appears in the text box.

1. In the RDP PowerShell session, paste <kbd>Ctrl+Shift+V</kbd> the script you copied, and then press <kbd>Enter</kbd>.

## Test the mounted drive

1. In the RDP connection, open File Explorer, and select **This PC**.

    :::image type="content" source="../media/4-explorer-mapped-drives.png" alt-text="Explorer showing This PC." lightbox="../media/4-explorer-mapped-drives.png":::

1. Under Network locations, select the file share named **F**.

1. Right-click the main work area, and in the context menu, select **New** > **Text Document**.

1. Rename the file **test upload**, and save it.

1. In the Azure portal, select the **File shares** pane, and select **data**. Verify that you can see the **test upload** file that you just created in the RDP session.

Keep this connection open for the next exercise.
