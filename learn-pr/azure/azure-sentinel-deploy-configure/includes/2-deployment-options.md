To deploy the proof-of-concept environment, your first step is to understand the capabilities and deployment considerations of Azure Sentinel.

## Use Azure Sentinel to retrieve data and monitor incidents

Azure Sentinel detects data incidents from connected sources, and then alerts you when action is necessary. You can use Azure Sentinel overviews, dashboards, and custom queries to gain insights into raw data and potentially malicious events.

Deploy connectors from Azure Sentinel to services to retrieve data from different data sources that Contoso's management wants to monitor. After Azure Sentinel retrieves the log data from the services, it performs correlation across data sources. You can manage that data by using the Azure Monitor Log Analytics workspace.

Azure Sentinel uses machine learning and AI to perform:

- Threat hunting
- Alert detection
- Fast responses to an incident

### Onboard Azure Sentinel

To onboard Azure Sentinel, you need to enable it, and then connect your data sources.

Azure Sentinel comes with a number of connectors for Microsoft and other solutions that are available out of the box. There are connectors for:

- Security Center
- Microsoft 365 sources, including Office 365
- Azure AD
- Azure ATP
- Cloud App Security
- Built-in connectors for partner solutions
- Built-in connector for Amazon Web Services

Additionally, there are built-in connectors to the broader security ecosystem for non-Microsoft solutions. You can also use Common Event Format (CEF), Syslog, or a REST API to connect your data sources with Azure Sentinel. The following image shows this connectivity capability.

:::image type="content" source="../media/sentinel-connections.png" alt-text="Diagram showing multiple data connections to Azure Sentinel." border="false":::

### Key factors for Azure Sentinel deployment

The lead system engineer at Contoso performed research and determined these key points:

- Azure Sentinel needs access to a Log Analytics workspace. The process is to create a Log Analytics workspace and enable Azure Sentinel on top of that workspace.
- Azure Sentinel is a paid service.
- Data retention for a customized workspace is based on the workspace pricing tier. If the Log Analytics workspace is used with Azure Sentinel, the first 90 days of retention are free.
- To enable Azure Sentinel, you need Contributor permissions to the subscription in which the Azure Sentinel workspace resides.
- To use Azure Sentinel, you need either Contributor or Reader permissions for the resource group to which the workspace belongs.

Azure Sentinel runs on workspaces in any general availability region of Log Analytics except the China and Germany regions. Certain data that Azure Sentinel generates might contain customer data sourced from these workspaces. For example, incidents, bookmarks, and alert rules. This data is saved in Europe for European workspaces, in Australia for Australian workspaces, or in East US for workspaces in any other region.

### How to deploy Azure Sentinel

Follow these steps to enable Azure Sentinel:

1. Sign in to the Azure portal.

1. Select the subscription that Azure Sentinel is to be created in. This account should have:
    
    1. Contributor permissions to the subscription where the Azure Sentinel workspace will be created.

    1. Contributor or Reader permissions on the resource group that the Azure Sentinel workspace will belong to.

1. Search for and select **Azure Sentinel**, and then select **Add**. The message **No Azure Sentinel workspace to display** pane appears.

1. Select **Create Azure Sentinel**. The **Add Azure Sentinel to a workspace** page appears.

1. Select **Create a new workspace**. The **Create Log Analytics workspace** pane appears.

1. On the **Basics** tab, use the dropdown lists to select the following values:

| Setting | Value  |
    | ------ | ------- |
    | **Project Details**  |
    | Subscription | The subscription that has Sentinel as a paid service |
    | Resource group | The resource group that has Contributor or Reader permissions |
    | **Instance Details** |
    | Name  | A unique name you want to use for the Log Analytics workspace |
    | Region | From the dropdown list, select the geographical location that applies to the Sentinel service subscription |
    

1. Select **Next : Pricing tier**
      
1. Select the Pricing tier.

1. Select **Review + Create**, wait for Azure to validate the settings for your Log Analytics workspace, and then select **Create**.

1. It may take some time for your workspace to be created. When the workspace has deployed to your resource group, you will receive a notification, and the name of your workspace appears in the Workspace list. Select the Notification icon in the top right of the Azure toolbar, and then select **Pin to dashboard**.
 
1. On the **Pin to dashboard pane**, select **Create new**, provide a name for your dashboard, and then select **Add** at the bottom of the pane. The Azure Sentinel dashboard  for your workspace appears.

1. In the left menu, select **Overview**.

### Monitor data feeds

The lead system engineer at Contoso discovered that after you connect security sources, you can monitor data feeds. 

Let's look at the basic structure of this Sentinel workspace. Sentinel is a cloud-native real-time Security Information And Event Management (SIEM) engine with predefined charts, graphs, and automation tools. The layout provides a top row with a summary count of monitored events, alerts, and incidents and a drop-down selection to dynamically change reporting range. Below are 3 panels with predefined graphical charts for events and incidents. The left menu, described in the table below, has a rich assortment of built-in tools for customizing and configuring data connections.

|Menu Item|Description|
|---|---|
| **General**  |
|Overview|The composite graphical view of events and incidents that you've configured.|
|Logs|Predefined queries you can run for all aspects of your Azure workspace, from applications to virtual machines to virtual networks.|
|News & guides|The starter pack for creating data connections, security alerts, and automation via built-in playbooks.|
| **Threat management**  |
|Incidents|Hands-on access to view all or selected the alerts and incidents you've configured.|
|Workbooks|Monitor data by using Azure Sentinel workbooks.|
|Hunting|Use the powerful hunting search-and-query tools that are based on the MITRE ATT&CK framework. Use these tools to proactively hunt for security threats across your organization's data sources.|
|Notebooks|Select from dozens of community-supplied tutorials and templates in all categories of SIEM and create your own library.|
|Entity behavior|View events based on account, host, or IP address|
|Threat intelligence|Use the deep investigation tools to understand the scope and find the root cause of potential security threats.|
| **Configuration**  |
|Data connectors|Set up connections to your security sources using a wide variety of devices and platforms. For example, select **Azure Activity** to view in real time the Azure Activity log.|
|Analytics|Azure Sentinel uses analytics to correlate alerts with incidents. Analytics help reduce noise and minimize the number of alerts to review and investigate.|
|Watchlist|Create custom watchlists to filter or suppress alerts to provide focused incident reporting in Sentinel.|
|Automation|Automate common tasks and simplify security orchestration with playbooks that interoperate with Azure services. They can work with existing tools.|
|Solutions|Create and customize end-to-end solutions for your Sentinel dashboard.|
|Community|Microsoft security analysts constantly create and add new workbooks, playbooks, hunting queries, and more. They post them to the community for all to use.|

The following screenshot shows the **Azure Sentinel - Overview** pane. Azure Sentinel can display real time charts and graphs to help you understand events, alerts, and incidents for security operations.

:::image type="content" source="../media/azure-sentinel-dashboard.png" alt-text="Screenshot of Azure Sentinel - Overview pane with several graphs and charts, including events and alerts over time, recent incidents, potential malicious events, and the total number of events, alerts, and incidents." lightbox="../media/azure-sentinel-dashboard.png"border="false":::
