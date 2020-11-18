In the previous unit, recall that you need to explore Azure native monitoring tools for your company. To further your knowledge, you'll need to know how to provision a Log Analytics workspace with the right permissions model, and you'll need to configure Azure Monitor for VMs to complete the process.

In this unit, you'll:

1. Create a Log Analytics workspace.
1. Configure the Log Analytics workspace permissions model for the environment you're supporting.
1. Create two virtual machines and onboard both to Azure Monitor for VMs.

## Create and configure Log Analytics workspace

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for and select **Log Analytics workspaces**.

1. Select **Add**.

1. Enter the following values to build the Log Analytics workspace. The Log Analytics workspace name must be globally unique, so we suggest using your initials and numbers (*xxxx-log-analytics* will represent the unique name for this module).

    :::image type="content" source="../media/3-create-log-analytics-workspace.png" alt-text="Screen shot of declaring the Log Analytics resource name, placing everything in the Concierge Subscription for Learn, and selecting Review + Create.":::

    | Property | Value |
    | ---- | ---- |
    | Subscription | Concierge Subscription |
    | Resource group | <rgn>[sandbox resource group name]</rgn> |
    | Name | xxxx-log-analytics |
    | Region | Select the region closest to you

1. Select **Review + Create** > **Create**.

1. After the resource deploys, select **Go to resource**.

1. Under **General**, select **Properties**.

1. Look for the access control mode and select **Use resource or workspace permissions**. This setting changes the access mode to use the resource-context.

    :::image type="content" source="../media/3-check-log-analytics-resource-context.png" alt-text="Screen shot of changing access control mode for Log Analytics workspace.":::

## Set up your environment

1. Run the following command in Azure Cloud Shell:

    ```bash
    az vm create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --location westus \
      --name SampleVM1 \
      --image UbuntuLTS \
      --admin-username azureuser \
      --generate-ssh-keys \
      --verbose
    ```

1. Once SampleVM1 finishes, run the the following command in Azure Cloud Shell:

    ```bash
    az vm create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --location westus \
      --name SampleVM2 \
      --image UbuntuLTS \
      --admin-username azureuser \
      --generate-ssh-keys \
      --verbose
    ```

## Onboard virtual machines to Azure Monitor for VMs

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for and select **Virtual machines**.

1. Select SampleVM1.

1. Under **Monitoring**, select **Insights** > **Enable**.

1. For **Choose a Log Analytics Workspace**, select the Log Analytics workspace you created.

1. Select **Enable** (onboarding Azure Monitor for VMs takes a few minutes).

    :::image type="content" source="../media/3-enable-azure-monitor-vms.png" alt-text="Enable Azure Monitor for VMs after selecting the right subscription and Log Analytics workspace.":::

1. Repeat the same steps for SampleVM2.

1. After 5-10 minutes have passed, under **Monitoring**, select **Insights**.

1. Review the map, which displays dependencies like processes running, ports open, connection details, health of the virtual machine, machine properties, and Azure virtual machine properties.

    :::image type="content" source="../media/3-azure-monitor-vms-map.png" alt-text="Azure Monitor for VMs screenshot, showcasing dependences and information about virtual machine." lightbox="../media/3-azure-monitor-vms-map.png":::

1. Next, select **Performance** at the top, right next to **Map**.

    :::image type="content" source="../media/3-virtual-machine-insights.png" alt-text="Screen shot after enabling Azure Monitor for VMs." lightbox="../media/3-virtual-machine-insights.png":::

1. Explore the different graphs for: 
    - Logical Disk Performance
    - CPU Utilization
    - Available Memory
    - Logical Disk IOPS
    - Logical Disk MB/s
    - Logical Disk Latency (ms)
    - Max Logical Disk Used %
    - Bytes Sent Rate
    - Bytes Received Rate

1. Experiment with different settings by moving from **Avg**, to **Min**, to **Max**, and so on (the virtual machines were only created a few minutes ago, so there might not be much data generated).

1. Select **Log Events** on the right-hand side of the page.

    :::image type="content" source="../media/3-log-events.png" alt-text="Screenshot of where Log Events show up within Azure Monitor for VMs." lightbox="../media/3-log-events.png":::

1. Select the **InsightsMetrics** table.

    :::image type="content" source="../media/3-azure-monitor-logs-data-summary.png" alt-text="Screen shot after selecting Log Events from the Azure Monitor for VMs pane.":::

1. The logs section of a Log Analytics workspace opens with a pre-populated query showing the data being collected.

    :::image type="content" source="../media/3-insights-metrics-log-analytics.png" alt-text="Screen shot after selecting the InsightsMetrics table and Log Analytics opening up for further query writing." lightbox="../media/3-insights-metrics-log-analytics.png":::
