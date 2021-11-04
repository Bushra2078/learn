Retention labels and policies help organizations to manage and govern information by ensuring content is kept only for a required time, and then permanently deleted.  Applying retention labels and assigning retention policies helps organizations:

- **Comply proactively with industry regulations and internal policies** that require content to be kept for a minimum time.
- **Reduce risk when there's litigation or a security breach** by permanently deleting old content that the organization is no longer required to keep.
- **Ensure users work only with content that's current and relevant to them**.
When content has retention settings assigned to it, that content remains in its original location. People can continue to work with their documents or mail as if nothing's changed. But if they edit or delete content that's included in the retention policy, a copy of the content is automatically kept in a secure location. The secure locations and the  content are not visible to most people. In most cases, people don't even need to know that their content is subject to retention settings.

Retention settings work with the following different workloads:

- [SharePoint and OneDrive](/microsoft-365/compliance/retention-policies-sharepoint)
- [Microsoft Teams](/microsoft-365/compliance/retention-policies-teams)
- [Yammer](/microsoft-365/compliance/retention-policies-yammer)
- [Exchange](/microsoft-365/compliance/retention-policies-exchange)

When using retention policies and retention labels to assign retention settings to content, there are some points to understand about each.  Listed below are just a few of the key points. For a more complete list visit [Compare capabilities for retention policies and retention labels](/microsoft-365/compliance/retention?view=o365-worldwide#compare-capabilities-for-retention-policies-and-retention-labels).

**Retention policies**

- Retention policies are used to assign the same retention settings to content at a site level or mailbox level.
- A single policy can be applied to multiple locations, or to specific locations or users.
- Items inherit the retention settings from their container specified in the retention policy. If a policy is configured to keep content, and an item is then moved outside that container, a copy of the item is kept in the workload's secured location. However, the retention settings don't travel with the content in its new location.

**Retention labels**

- Retention labels are used to assign retention settings at an item level, such as a folder, document, or email.
- An email or document can have only a single retention label assigned to it at a time.
- Retention settings from retention labels travel with the content if it’s moved to a different location within your Microsoft 365 tenant.
- Admins can enable users in the organization to apply a retention label manually.
- A retention label can be applied automatically if it matches defined conditions.
- A default label can be applied for SharePoint documents.
- Retention labels support disposition review to review the content before it's permanently deleted.

Consider the following scenarios.  If all documents in a SharePoint site should be kept for five years, it's more efficient to do with a retention policy than apply the same retention label to all documents in that site.

However, if some documents in that site should be kept for five years and others for 10 years, you'd need to apply a policy to the SharePoint site with a retention period of five years. You'd then apply a retention label to the individual item with a retention setting of 10 years.
