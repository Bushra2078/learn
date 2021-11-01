Azure role-based access control (Azure RBAC) is the authorization system that manages access to Azure resources. It's built on Azure Resource Manager, which provides fine-grained access management of Azure resources.

Use Azure RBAC to create and assign roles in your SecOps team. Azure RBAC lets you grant appropriate access to Microsoft Sentinel. The different roles give you specific control over what users of Microsoft Sentinel can access and do.

## Microsoft Sentinel-specific roles

The following are the three dedicated, built-in Microsoft Sentinel roles:

- **Reader**: This role can review data, incidents, workbooks, and other Microsoft Sentinel resources.

- **Responder**: This role has all the permissions of the Reader role. Plus, it can manage incidents by assigning or dismissing them.

- **Contributor**: This role has all the permissions of the Reader and Responder roles. Also, it can create and edit workbooks, analytics rules, and other Microsoft Sentinel resources. To deploy Microsoft Sentinel on your tenant, you need Contributor permissions for the subscription where the Microsoft Sentinel workspace is deployed.

All built-in Microsoft Sentinel roles grant read access to the data in your Microsoft Sentinel workspace. For best results, these roles should be assigned to the resource group that contains the Microsoft Sentinel workspace. The roles then apply to all the resources that deploy to support Microsoft Sentinel, if those resources are in the same resource group.

## Azure roles and Azure Monitor Log Analytics roles

In addition to Microsoft Sentinel-dedicated Azure RBAC roles, other Azure and Log Analytics Azure RBAC roles can grant a wider set of permissions. These roles include access to your Microsoft Sentinel workspace and other resources.

- Azure roles grant access across all your Azure resources. They include Log Analytics workspaces and Microsoft Sentinel resources:

  - Owner

  - Contributor

  - Reader

- Log Analytics roles grant access across all your Log Analytics workspaces:

  - Log Analytics Contributor

  - Log Analytics Reader

For example, a user who is assigned with the Microsoft Sentinel Reader and Azure Contributor (not Microsoft Sentinel Contributor) roles can edit data in Microsoft Sentinel. If you want to only grant permissions to Microsoft Sentinel, you should carefully remove the user's prior permissions. Make sure you don't break any needed permission role for another resource.

## Microsoft Sentinel roles and allowed actions

The following table summarizes the roles and allowed actions in Microsoft Sentinel.

| Roles| Create and run playbooks| Create and edit workbooks, analytic rules, and other Microsoft Sentinel resources| Manage incidents such as dismissing and assigning| View data incidents, workbooks, and other Microsoft Sentinel resources|
| :--- | :---: | :--- | :--- | :--- |
| Microsoft Sentinel Reader| No| No| No| Yes|
| Microsoft Sentinel Responder| No| No| Yes| Yes|
| Microsoft Sentinel Contributor| No| Yes| Yes| Yes|
| Microsoft Sentinel Contributor and Logic App Contributor| Yes| Yes| Yes| Yes|

## Custom roles and advanced Azure RBAC

If the built-in Azure roles don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals for management-group, subscription, and resource-group scopes.
