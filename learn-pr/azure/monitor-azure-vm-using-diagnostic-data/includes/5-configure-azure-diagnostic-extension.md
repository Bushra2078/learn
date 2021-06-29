If you need to capture Guest OS performance metrics in addition to the standard virtual machine host metrics, install the Azure Monitor Agent. You install the agent and configure the data to be collected using Data Collection Rules.

Your band is on tour next month, and you have identified specific metrics that will help you monitor the health of your virtual machine (VM). The metrics that you want to monitor go beyond the standard virtual machine host metrics available in the Azure portal. You've decided to use the Azure Monitor Agent for guest OS visibility.

In this unit, you'll see how to install the Azure Monitor Agent to monitor the health of a VM. You'll learn how to enable the agent for an existing VM.

## Install the Azure Monitor Agent using Data Collection Rules

The Azure Monitor Agent allows you to collect real-time performance metrics from the guest operating system, along with log events, and store the results in Azure Monitor Metrics and Azure Monitor Logs.

If you've already created the VM, the easiest way to add the agent is by going to **Azure Monitor, Data Collection Rules** to create a new Data Collection Rule and add the VM as a data source. Data collection rules define the scope of VMs where data will be captured, the metrics or logs to be collected, and the destination(s) where the data will be stored.

![Screenshot of the Data Collection Rules Landing Page with rule](../media/5-enable-diagnostics-portal.png)

Resources allow you to select which VM(s) to collect data from for monitoring. Data sources define the metrics and logs you want to collect and where that data will be sent and stored.

![Screenshot of the Data Collection Rules definition](../media/5-enable-diagnostics-portal.png)

Performance Counters to be collected can be selected from a basic or customized and filtered from an expanded list.

![Screenshot of the Data Collection Rules Data Sources](../media/5-enable-diagnostics-portal.png)

Performance counters can be sent to Azure Monitor Metrics and/or Azure Monitor Logs. Azure Monitor metrics is a time-series data store optimized for near-real time visualizations and alerts. Azure Monitor Logs supports more sophisticated data analysis such as trending and pattern recognition using queries.

![Screenshot of the Data Collection Rules Data Sources](../media/5-enable-diagnostics-portal.png)

The Azure Monitor Agent can collect metrics and logs and can send the data to Azure Monitor metrics and/or multiple Azure Monitor Logs workspaces. However, note that this unit only focused on the metric collection capabilities of the agent.
