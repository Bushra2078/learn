The Threat detection with Microsoft Sentinel Analytics exercise in this module is an optional unit. However, if you want to perform this exercise, you need access to an Azure subscription where you can create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

To deploy the prerequisites for the exercise, perform the following tasks.

> [!NOTE]
> If you choose to perform the exercise in this module, be aware you might incur costs in your Azure Subscription. To estimate the cost, refer to [Microsoft Sentinel Pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/).

## Task 1: Deploy Microsoft Sentinel using ARM template

1. Select the following link:

    [![Deploy To Azure.](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-security-ops-sentinel%2Fmain%2Fmslearn-analyze-data-in-sentinel%2Fsentinel-template.json?azure-portal=true)

    You're prompted to sign in to Azure. The **Custom deployment** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project details** |
    | Subscription | Select your Azure subscription. |
    | Resource group | Select **Create new**, and provide a name for the resource group, such as `azure-sentinel-rg`.|
    | **Instance details** |
    | Region | From the dropdown list, select the location where you want to deploy the Microsoft Sentinel. |
    | Workspace Name  | Provide a unique name for the Microsoft Sentinel Workspace such as `<yourName>-sentinel`, where *\<yourName>* represents the workspace name that you chose in the previous task. |
    | Location | Accept the default value of `[resourceGroup().location]`. |
    | Simplevm Name | Accept the default value of `simple-vm`. |
    | Simplevm Windows OS Version | Accept the default value of `2016-Datacenter`. |

1. Select the **Review + create**. When validation passes, select **Create**.

    :::image type="content" source="../media/02-custom-deployment.png" alt-text="Screenshot of the Custom Deployment page." border="true":::

    > [!Note]
    > Wait for the deployment to complete. The deployment should take less than five minutes.

## Task 2: Check the resources created

1. In the Azure portal, search for **Resource groups**.

1. Select `azure-sentinel-rg`.

1. Sort the list of resources by **Type**.

    The resource group should contain the resources listed in the following table.

    | Name  | Type  | Description |
    |---|---|---|
    | `<yourName>-sentinel` | Log Analytics workspace | Log Analytics workspace used by Microsoft Sentinel, where *\<yourName>* represents the workspace name that you chose in the previous task. |
    | `simple-vmNetworkInterface` | Network interface | Network interface for the  VM. |
    | `SecurityInsights(<yourName>-sentinel)` | Solution | Security insights for Microsoft Sentinel. |
    | `simple-vm` | Virtual machine | Virtual machine used in the demonstration. |
    | `st1<xxxxx>` | Storage account | Storage account used by the virtual machine, where *\<xxxxx>* represents a random string generated to create a unique storage account name. |
    | `simple-vm` | Virtual Machine | Virtual machine. |
    | `vnet1` | Virtual network | Virtual network for the VM. |

> [!NOTE]
> The resources deployed and configuration steps completed in this exercise are required in the next exercise. If you intended completing the next exercise, do not delete the resources from this exercise.

## Task 3: Configure Microsoft Sentinel connectors

In this task, you'll deploy a Microsoft Sentinel connector to Azure Activity.

1. In the Azure portal, select **Home**, and then search for and select **Microsoft Sentinel**.

1. In the list of Sentinel workspace names, select the Microsoft Sentinel workspace you created in Task 2. The **Overview** pane for your Sentinel workspace appears.

1. In the middle menu pane, under **Configuration**, select **Data connectors**. The **Data connectors** pane appears.

1. In the *Search by name or provider* search box, search for and select **Azure Activity**. The **Azure Activity** details pane appears.

1. Select **Open connector page**. The **Azure Activity** pane reappears.

1. Select the **Configure Azure Activity logs** link.

1. Select your subscription, and then select **Connect**.

1. When you receive a status of **Connected**, close all open panels to return to **Microsoft Sentinel | Data connector**.

:::image type="content" source="../media/07-azure-sentinel-connector.png" alt-text="Screenshot of the Microsoft Sentinel connector." border="true":::

> [!Note]
> The connector for Azure Activity could take 20 minutes to send data in Microsoft Sentinel. You can proceed with rest of the steps and with other units of this module.
