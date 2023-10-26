In this unit, you explore Azure monitoring capabilities for VMs, and the types of monitoring data Azure Monitor can collect and analyze. Azure Monitor is a comprehensive monitoring solution for collecting, analyzing, and responding to monitoring data from Azure resources, including VMs. Azure Monitor has two main monitoring features: Azure Monitor Metrics and Azure Monitor Logs.

Metrics are numerical values collected at predetermined intervals to describe some aspect of a system. Metrics can measure VM performance, resource utilization, error counts, user responses, or any other aspect of the system that you can quantify. Azure Monitor Metrics automatically monitors a predefined set of metrics for every Azure VM, and retains the data for 93 days with some exceptions.

Logs are recorded system events that contain a timestamp and different types of structured or free-form data. Azure automatically records platform logs for all Azure resources. Azure Monitor doesn't collect logs by default, but you can configure Azure Monitor Logs to collect and analyze logs from any Azure resource. Azure Monitor Logs can store structured and unstructured log data in Log Analytics workspaces for querying and analysis.

## VM architecture

Azure VMs have several layers that require monitoring. Each of the following layers has a distinct set of telemetry and monitoring requirements.

- Host VM
- Guest operating system (OS)
- Client workloads
- Applications that run on the VM

:::image type="content" source="../media/monitoring-layers.png" alt-text="Diagram that shows fundamental VM architecture." border="false":::

## Host VM monitoring

For an Azure VM, the VM host represents the compute, storage, and network resources that Azure allocates to the VM.

### VM host metrics

VM host metrics track and alert on activity such as configuration changes, processor utilization, and whether the machine is running. By viewing VM host metrics, you can:

- Get alerts when your VMs are reaching their disk and CPU limits.
- Detect trends or patterns.
- Control your operational costs by sizing VMs according to usage and demand.

Azure automatically collects basic metrics for host VMs. On the VM's Azure portal page, you can see built-in graphs for the following important VM host metrics. You can customize the displayed range from the past hour to the past 30 days.

- VM availability
- CPU usage percentage (average)
- OS disk usage (total)
- Network operations (total)
- Disk operations per second (average)

You can use Azure Monitor Metrics Explorer to plot more metrics graphs, investigate changes, and visually correlate metrics trends for your VMs. With Metrics Explorer you can:

- Plot multiple metrics on a graph to see how much traffic hits your VM and how the VM performs.
- Track the same metric over multiple VMs in a resource group or other scope, and use splitting to show each VM on the graph.
- Select flexible time ranges and granularity.
- Specify many other settings such as chart type and value ranges.
- Send graphs to workbooks or pin them to dashboards for quickly viewing health and performance.
- Group metrics by time intervals, geographic regions, server clusters, or application components.

:::image type="content" source="../media/2-vm-metrics-screenshot.png" alt-text="Screenshot showing CPU percentage usage and inbound flow chart." lightbox="../media/2-vm-metrics-screenshot.png":::

### Recommended alert rules

Azure Monitor alerts proactively notify you of specified occurrences and patterns in your VM host metrics. *Recommended alert rules* are a predefined set of alert rules based on common host metrics. These rules define CPU, memory, disk, and network usage levels to alert on, including VM availability, which alerts when the VM stops running.

You can quickly enable and configure recommended alert rules when you create an Azure VM, or afterwards from the VM's portal page. You can also view, configure, and create custom alerts by using Azure Monitor Alerts.

### Activity logs

Azure Monitor automatically records and displays activity logs for Azure VMs. Activity logs include information like VM startup or modifications. You can create diagnostic settings to send activity logs to the following destinations:

- Azure Monitor Logs, for more complex querying and alerting and for longer retention up to two years.
- Azure Storage, for cheaper, long-term archiving.
- Azure Event Hubs, to forward outside of Azure.

### Boot diagnostics

Boot diagnostics are host event monitoring you can use to help troubleshoot boot issues with your VMs. You can enable boot diagnostics by default when you create a VM, or afterwards for existing VMs.

Once you enable boot diagnostics, you can see screenshots from the VM's hypervisor for both Windows and Linux machines, and view the serial console log output of the VM boot sequence for Linux machines. Boot diagnostics stores data in a managed storage account.

## Guest OS, client workload, and application monitoring

VM clients are the operating systems, workloads, and applications that an Azure VM runs. To collect metrics and logs from guest OS and client workloads and applications, you set up a data collection rule (DCR) that installs the Azure Monitor Agent and collects data on the VM clients.

DCRs define what data to collect and where to send that data. You can send data to Azure Monitor Logs and Azure Monitor Metrics. Azure Monitor Metrics can store only metrics data, but Azure Monitor Logs can store both metrics and performance counters.

### VM Insights

VM Insights is a feature in Azure Monitor that helps get you started monitoring your VM clients. By using VM Insights, you get:

- Simplified Azure Monitor Agent onboarding to enable monitoring a VM's guest OS and workloads.
- A preconfigured DCR that monitors and collects the most common performance counters for Windows and Linux.
- Predefined trending performance metrics charts and workbooks from the VM's guest OS.
- A set of predefined workbooks that show collected VM client metrics over time.
- Optionally, collection of processes running on the VM, dependencies with other services, and a dependency map that displays interconnected components with other VMs and external sources.

VM Insights creates a DCR that sends client VM performance counters to Azure Monitor Logs. Because the DCR sends its metrics to Azure Monitor Logs, you don't use Metrics Explorer to view the metrics data that VM Insights collects.

Predefined VM Insights workbooks show performance, connections, active ports, traffic, and other collected data from one or several VMs. You can view VM Insights data directly from a single VM, or see a combined view of multiple VMs to view and assess trends and patterns across VMs. You can edit the prebuilt workbook configurations or create your own custom workbooks.

VM Insights is especially useful for exploring overall VM usage and performance when you don't yet know the metric of primary interest. Unlike other usage analytics tools, VM Insights workbooks combine multiple kinds of visualizations and analyses, such as CPU utilization, disk space and IOPS, available memory, and bytes sent and received.

### Client event log data

VM Insights creates a DCR that collects a specific set of performance counters. To collect other data, such as event logs, you can create a separate DCR that specifies the data you want to collect from the VM and where to send it.

Azure Monitor Agent DCRs can send client performance counter data to both Azure Monitor Metrics and Azure Monitor Logs, but you can send event log data only to Azure Monitor Logs. Azure Monitor stores and analyzes logs in a Log Analytics workspace, where you can access them by using log queries written in Kusto Query Language (KQL).

