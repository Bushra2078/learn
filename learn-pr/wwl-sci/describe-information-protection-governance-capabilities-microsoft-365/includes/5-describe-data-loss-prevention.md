Data loss can harm an organization’s customers, business processes, and the organization itself. Organizations need to be able to prevent data loss, by detecting risky behavior and preventing sensitive information from being shared inappropriately. Admins can enable their organization to prevent data loss through data loss prevention policies available in Microsoft 365 Compliance Center.

Data loss prevention (DLP) is a way to protect sensitive information and prevent its inadvertent disclosure. Data loss prevention can be implemented through policies in Microsoft 365 Compliance Center. With DLP policies, admins can:

- **Identify, monitor, and automatically protect** sensitive information across Microsoft 365, including:

  - OneDrive for Business
  - SharePoint Online
  - Microsoft Teams
  - Exchange Online
- **Help users learn how compliance works** without interrupting their workflow. For example, if a user tries to share a document containing sensitive information, a DLP policy can both send them an email notification and show them a policy tip.
- **View DLP reports** showing content that matches the organization's DLP policies. To assess how the organization is complying with a DLP policy, admins can see how many matches each policy has over time.

DLP policies protect content through the enforcement of rules that consist of:

- **Conditions** that the content must match before the rule is enforced.
- **Actions** that the admin wants the rule to take automatically when content that matches the conditions has been found.
- **Locations** where the policy will be applied, such as Exchange, SharePoint, OneDrive, and more

For example, an admin can configure a DLP policy that helps detect information that is subject to a compliance regulation like the Health Insurance Portability and Accountability Act (HIPAA) across all SharePoint sites and OneDrive for Business, and block the relevant documents from being shared inappropriately.

Data loss prevention policies protect information by identifying and automatically protecting sensitive data.
Here are some scenarios data loss prevention policies can help address:

- Identify any document containing a credit card number stored in users’ OneDrive for Business accounts.
- Automatically block an email containing employee personal information from being sent outside the organization.

A policy can contain one or more rules, and each rule consists of conditions and actions at a minimum. For each rule, when the conditions are met, the actions are taken automatically. Rules can be grouped into one policy, to help simplify management and reporting.  The diagram below shows how multiple rules, each with their own conditions and actions, are grouped into a single policy:

:::image type="content" source="../media/5-dlp-rules.png" alt-text="Diagram showing how a single policy can consist of multiple rules.":::

The rules inside the policy are prioritized in how they’re implemented. For example, in the above diagram, rule one will be prioritized before rule two, and so on.

## What is endpoint data loss prevention?

Endpoint data loss prevention is how the protection and activity monitoring capabilities of DLP for sensitive content can be extended to Windows 10 devices.  To achieve this, admins can choose to target Windows 10 when creating a DLP policy (after onboarding the devices to Microsoft 365 compliance solutions). Endpoint DLP enables admins to audit and manage activities that users perform on sensitive content, including:

- Creating an item
- Renaming an item
- Copying items to removable media
- Copying items to network shares
- Printing documents
- Accessing items using unallowed apps and browsers

Information about what users are doing with sensitive content is viewable in the activity explorer:

:::image type="content" source="../media/5-activity-explorer-endpoint-dlp.png" alt-text="The activity explorer show activities monitored through endpoint DLP.":::

Admins can use this information to enforce protective actions for content through controls and policies.

## Data loss prevention in Microsoft Teams

Data loss prevention capabilities have been extended to Microsoft Teams chat and channel messages, including messages in private channels. With DLP, administrators can now define policies that can prevent users from sharing sensitive information in a Teams chat session or Teams channel, whether this information is in a message, or in a file. Just like with Exchange, Outlook, SharePoint, and OneDrive for Business, administrators can use DLP policy tips that will be displayed to the user to show them why a policy has been triggered. For example, the screenshot below shows a policy tip on a chat message that was blocked because the user attempted to share a U.S. Social Security Number:

:::image type="content" source="../media/5-dlp-policy-tip.png" alt-text="A policy tip is shown in Microsoft Teams so that the user knows why their message was blocked.":::

The user can then find out more information about why their message was blocked by selecting the "What can I do?" link, so they can take appropriate action:

:::image type="content" source="../media/5-policy-tip-more-information.png" alt-text="The user can find more information about why their message was blocked, and take recommended actions.":::

With DLP policies, Microsoft Teams can help users across organizations to collaborate securely and in a way that is in line with compliance requirements.
