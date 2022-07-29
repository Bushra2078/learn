In this exercise, we'll configure cross-tenant access settings for a specific organization. These settings will take precedence over the default cross-tenant access settings for this organization only.

Recall that in the financial institution example, the default cross-tenant access settings are configured so that outbound B2B collaboration is allowed, but inbound B2B collaboration is blocked for all external Azure AD organizations. But now that the financial institution has acquired a branch, they want to allow those branch users to access internal applications using B2B collaboration. They also want to make sure that if the user has completed multi-factor authentication in their home tenant, they won't be asked to do so again.

![Diagram of the full financial institution example, with just the organizational settings highlighted.](../media/5-scenario-organizational.png)

To try this exercise yourself, you need an Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) and add a subscription before you begin. If you're a student, you can take advantage of the [Azure for students](https://azure.microsoft.com/free/students/?azure-portal=true) offer.

## Create organizational settings

Here, you'll add an organization to your cross-tenant access settings. Then you'll configure the organization's inbound cross-tenant access settings to allow the organization's users to access your applications through B2B collaboration. You won't make any changes to the organization's outbound settings, which means your default settings will apply and other Azure AD organizations will be able to invite your users to their organization for B2B collaboration.

### Open the Azure Active Directory service in the portal

1. Open a web browser.
2. In the address bar, type https://portal.azure.com.
3. Sign in using your Azure AD admin account.
4. Open the Azure Active Directory service with the following steps:
   - Under **Azure services**, select **Azure Active Directory**, or
   - Use the search box search for "Azure Active Directory" and then select it.

## Add an organization

1. On the left navigation bar, select **External Identities**.
2. Select **Cross-tenant access settings**.
1. Select the **Organizational settings** tab.
2. Select **Add organization**.

   ![Screenshot showing Add organization selection.](../media/5-add-organization.png)

1. On the **Add organization** pane, type the full domain name (or tenant ID) for the organization.
2. Select the organization in the search results, and the select **Add**.

   ![Screenshot showing the add organization pane with an organization selected.](../media/5-add-organization-selected.png)

Now the organization appears in the **Organizational settings** list. You'll notice that the settings in the **Inbound access** and **Outbound access** columns are all set to **Inherited from default**. Stay on this page and go to the next section to modify the inbound access settings for the organization.

   ![Screenshot of the Organizational settings list with the org showing.](../media/5-organizational-settings-list.png)

## Modify the inbound settings for the organization

1. In the **Organizational settings** list, find the organization in the list and select the link in the **Inbound access** column.
2. Select **B2B collaboration**.
3. Select **Customize settings**.
4. Select **External users and groups**.
5. Under **Access status**, select **Allow access**.
6. Under **Applies to**, make sure **All &lt;organization name&gt; users and groups** is selected.

   ![Screenshot showing inbound access settings for an organization with inbound access set to all allowed.](../media/5-organizational-inbound-allowed.png)

3. Select **Save**. You'll return to the main Cross-tenant access settings page. Stay on this page and go to the next section to configure the multi-factor trust setting.

## Trust multi-factor authentication from the organization

When you choose to trust multi-factor authentication, your Conditional Access policies will trust claims from the external organization about whether their user has completed multi-factor authentication in their home tenant. During authentication, Azure AD will check a user's credentials, and if a claim exists indicating that the user has completed multi-factor authentication, they won't be asked to do so again.

1. In the **Organizational settings** list, find the organization in the list and select the link in the **Inbound access** column.
1. Select the **Trust settings** tab.
2. Select **Customize settings**.
3. Select **Trust multi-factor authentication from Azure AD tenants**. 

   ![Screenshot of the Trust settings page with the multi-factor authentication trust option selected.](../media/5-organizational-mfa-trust.png)

Stay on this page to check your work in the next section.

## Check your work

On the main **Cross-tenant access settings** page, select the Organizational settings tab. Make sure the organization you added appears in the list and has the following settings:

- The **Inbound access settings** column should show **All allowed**.
- The **Outbound access** column should show **Inherited from default**.

![Screenshot of organizational settings showing an organization with inbound access set to All allowed and outbound access set to Inherited from default.](../media/5-organizational-settings-inbound-configured.png)

All users from the external organization can now be invited to your organization for B2B collaboration. And because this organization inherits outbound settings from your defaults, your users can also be invited to the external organization for B2B collaboration.