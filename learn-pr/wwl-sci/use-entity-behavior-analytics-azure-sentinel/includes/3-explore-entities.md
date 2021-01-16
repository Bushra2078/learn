When alerts are sent to Azure Sentinel, they include data elements that Azure Sentinel identifies and classifies as entities, such as user accounts, hosts, IP addresses and others. On occasion, this identification can be a challenge, if the alert does not contain sufficient information about the entity.

For example, user accounts can be identified in more than one way: using an Azure AD account’s numeric identifier (GUID), or its User Principal Name (UPN) value, or alternatively, using a combination of its username and its NT domain name. Different data sources can identify the same user in different ways. Therefore, whenever possible, Azure Sentinel merges those identifiers into a single entity, so that it can be properly identified.

It can happen, though, that one of your resource providers creates an alert in which an entity is not sufficiently identified - for example, a user name without the domain name context. In such a case, the user entity cannot be merged with other instances of the same user account, which would be identified as a separate entity, and those two entities would remain separate instead of unified.

In order to minimize the risk of this happening, you should verify that all of your alert providers properly identify the entities in the alerts they produce. Additionally, synchronizing user account entities with Azure Active Directory may create a unifying directory, which will be able to merge user account entities.

The following types of entities are currently identified in Azure Sentinel:

- User account (Account)

- Host

- IP address (IP)

- Malware

- File

- Process

- Cloud application (CloudApplication)

- Domain name (DNS)

- Azure resource

- File (FileHash)

- Registry key

- Registry value

- Security group

- URL

- IoT device

- Mailbox

- Mail cluster

- Mail message

- Submission mail

### Entity pages

When you encounter any entity (currently limited to users and hosts) in a search, an alert, or an investigation, you can select the entity and be taken to an **entity page**, a datasheet full of useful information about that entity. The types of information you will find on this page include basic facts about the entity, a timeline of notable events related to this entity and insights about the entity's behavior.

Entity pages consist of three parts:

- The left-side panel contains the entity's identifying information, collected from data sources like Azure Active Directory, Azure Monitor, Azure Security Center, and Microsoft Defender.

- The center panel shows a graphical and textual timeline of notable events related to the entity, such as alerts, bookmarks, and activities. Activities are aggregations of notable events from Log Analytics. The queries that detect those activities are developed by Microsoft security research teams.

- The right-side panel presents behavioral insights on the entity. These insights help to quickly identify anomalies and security threats. The insights are developed by Microsoft security research teams, and are based on anomaly detection models.

### The timeline

![UEBA Timeline](../media/euba4.png)

The timeline is a major part of the entity page's contribution to behavior analytics in Azure Sentinel. It presents a story about entity-related events, helping you understand the entity's activity within a specific time frame.

You can choose the **time range** from among several preset options (such as *last 24 hours*), or set it to any custom-defined time frame. Additionally, you can set filters that limit the information in the timeline to specific types of events or alerts.

The following types of items are included in the timeline:

Alerts - any alerts in which the entity is defined as a **mapped entity**. Note that if your organization has created [custom alerts using analytics rules](https://docs.microsoft.com/en-us/azure/sentinel/tutorial-detect-threats-custom), you should make sure that the rules' entity mapping is done properly.

Bookmarks - any bookmarks that include the specific entity shown on the page.

Activities - aggregation of notable events relating to the entity.

### Entity Insights

Entity insights are queries defined by Microsoft security researchers to help your analysts investigate more efficiently and effectively. The insights are presented as part of the entity page, and provide valuable security information on hosts and users, in the form of tabular data and charts. Having the information here means you don't have to detour to Log Analytics. The insights include data regarding sign-ins, Group Additions, Anomalous Events and more, and include advanced ML algorithms to detect anomalous behavior. The insights are based on the following data types:

- Syslog

- SecurityEvent

- Audit Logs

- Sign-in Logs

- Office Activity

- BehaviorAnalytics (UEBA)

### How to use entity pages

Entity pages are designed to be part of multiple usage scenarios, and can be accessed from incident management, the investigation graph, bookmarks, or directly from the entity search page under **Entity behavior analytics** in the Azure Sentinel main menu.

![Entity Page](../media/euba5.png)

