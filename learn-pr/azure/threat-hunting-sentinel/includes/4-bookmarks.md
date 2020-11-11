To hunt for threats to Contoso's environment, you have to review large amounts of log data for evidence of malicious behavior. During this process, you might find events that you want to remember, revisit, and analyze as part of validating potential hypotheses and understanding the full story of a compromise.

## Hunt using bookmarks

Hunting bookmarks in Azure Sentinel can help you hunt for threats by preserving the queries you ran in Azure Sentinel, along with the query results that you deem relevant. You can also record your contextual observations and reference your findings by adding notes and tags. Bookmarked data is visible to you and your teammates for easy collaboration.

You can revisit your bookmarked data at any time on the Bookmarks tab of the Hunting pane. You can use filtering and search options to quickly find specific data for your current investigation. Alternatively, you can view your bookmarked data directly in the HuntingBookmark table in your Log Analytics workspace.

Bookmarked events contain standard event information, but can be used in different ways throughout the Azure Sentinel interface.

## Create or add to incidents using bookmarks

You can use bookmarks to create a new incident or add bookmarked query results to existing incidents. The **Incident actions** button on the toolbar enables you perform either of these tasks when a bookmark is selected.

:::image type="content" source="../media/4-incident-actions.png" alt-text="The Incident actions interface in Azure Sentinel" :::

Incidents created from bookmarks can be managed from the **Incidents** page alongside other incidents created in Azure Sentinel.

## Use the investigation graph to explore bookmarks

You can investigate bookmarks in the same way you would investigate incidents in Azure Sentinel. From the Hunting page, select **Investigate** to open the investigation graph for the incident. This action opens the investigation graph, a visual tool that helps to identify entities involved in the attack and the relationships between those entities. If the incident involves multiple alerts over time, you can also review the alert timeline and correlations between alerts

:::image type="content" source="../media/4-investigation-graph.png" alt-text="The screenshot shows the **Investigation graph** page.":::

#### Review entity details

You can select each entity on the graph to observe more information about the entity. This information provides complete contextual entity information, including relationships to other entities, account usage, and data flow information. For each information area, you can navigate to the related events in Log Analytics and add the related alert data into the graph.

#### Review bookmark details

You can select the bookmark item on the graph to observe important bookmark metadata related to the bookmark's security and environment context.
