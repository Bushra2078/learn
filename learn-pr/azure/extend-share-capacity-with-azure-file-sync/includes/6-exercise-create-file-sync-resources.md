Now that you know your server is compatible with Azure File Sync, you're ready to set up your Azure resources. In this exercise, you'll create the four components that you need to connect your company's file server.

The following video shows how to create the Azure resources you'll need. Use the steps in this exercise to continue following along in your Azure subscription.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4LBmt]

## Create the storage account

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. In the top search box, search for and select **Storage accounts**. The **Storage accounts** pane appears.

1. In the top menu bar, select **Create**. The **Create a storage account** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

   | Setting | Value  |
   |---------|---------|
   | **Project details** |
   | Subscription | *Subscription associated with your account.* |
   | Resource group | Select the **Create new** link, and enter **learn-file-sync-rg** |
   | **Instance details** |
   | Storage account name   | **extendcadfiles** |

1. Accept the defaults for the rest of the values.

1. Select **Review + create**, and after validation passes, select **Create**.

## Create the file share

Wait for the storage account to be created.

1. When deployment completes, select **Go to resource**. Your **Storage account** pane appears.

1. In the left menu pane, under **Data storage**, select **File shares**. The **File shares** pane appears for your storage account.

1. In the top menu pane, select **File share**. The **New file share** pane appears.

1. Enter the following values for each setting.

   | Setting | Value  |
   |---------|---------|
   | Name    | **cadfileshare** |
   | Tier    | **Transaction optimized** |

1. Select **Create**. The **File shares** pane reappears for your storage account.

## Create the Storage Sync Service

1. In the upper-left corner of the portal, in the breadcrumb, select **Home**. The **Home** page for the Azure portal appears.

1. Under **Azure services**, select **Create a resource**.

1. In the *Search services and marketplace* search box, search for and select **Azure File Sync**. The **Azure File Sync** pane appears.

1. Select **Create**. The **Deploy Azure File Sync** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

   | Setting |Value  |
   |---------|---------|
   | Subscription | *Subscription associated with your account.* |
   | Resource group | From the dropdown list, select **learn-file-sync-rg** |
   | Storage sync service name  | **CADSyncService** |

1. Select **Review + Create**, and then select **Create** to deploy the Storage Sync Service.

## Create a sync group

Wait for the Storage sync service to be created.

1. When deployment completes, select **Go to resource**. Your **Storage Sync Service** pane appears.

1. In the top menu bar, select **Sync group**. The **Sync group** pane appears.

1. Enter the following values for each setting.

   | Setting | Value  |
   |---------|---------|
   | Sync group name | **CADFiles** |
   | Storage account | Select **Select storage account**, and then select **extendcadfiles**. |
   | Azure File Share | From the dropdown list, select **cadfileshare**. |

1. Select **Create**.
