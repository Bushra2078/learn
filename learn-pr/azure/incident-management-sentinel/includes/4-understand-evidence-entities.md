Azure Sentinel uses various sources of security information to create incidents. As lead system engineer at Contoso, you'll need to understand these sources to best utilize Azure Sentinel's incident management.

## Incident evidence

Incident evidence consists of the security event information and related Azure Sentinel assets that identify threats in the Azure Sentinel environment. Evidence displays how a threat has been identified in Azure Sentinel and it links you back to the specific resources that you can use to increase you awareness of incident details.

### Events

Events link you back to one or more events from the Log Analytics workspaces associated with Azure Sentinel. On their own, these workspaces typically contain thousands of events that are too numerous to manually parse. If a query attached to an Azure Sentinel analytics rule returns event, these events are attached to the generated incident for potential further review. You can use events to understand the scope and frequency of the incident before investigating further.

### Alerts

Most incidents are generated because of an analytics rule alert. Examples of alerts include:

- Detection of suspicious files
- Detection of suspicious user activities
- Attempted elevation of privilege

Analytics rules generate alerts, either based on KQL queries or direct connection to Microsoft Security solutions such as Azure Security Center or Microsoft Defender 365. If you enable alert grouping Azure Sentinel includes any related alerts evidence for the incident.

### Bookmarks

While investigating an incident, you might identify events that you want to track or mark for later investigation. You can preserve the queries ran in Log Analytics by choosing one or more events and designating them as bookmarks. You can also record notes and tags to better inform later threat hunting processes. Bookmarks are available to you and your teammates.

## Incident entities

An entity refers to a network or user resource involved with an event. You can use entities as entry points to explore all alerts and correlations associated with that entity. Entity relationships are useful when investigating incidents. Instead of analyzing the identity alerts, network alerts, and data access alerts individually, you can use entities to observe any alerts associated with a particular user, host, or address in your environment. Some of the entity types include:

- Account
- Host
- IP
- URL
- FileHash

For instance, entities would help you identify all of the alerts associated with a specific user at Contoso, the user's host machine, and other hosts the user has connected to. You can determine which IP addresses are associated with the user in question, exposing which events and alerts could be part of the same attack.

Choose the best response for each of the questions below. Then select “Check your answers.”
