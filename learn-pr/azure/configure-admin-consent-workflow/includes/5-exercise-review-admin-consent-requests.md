In this exercise, as the designated reviewer, you sign in to the Azure portal, view the admin consent request and act on it.

> [!NOTE]
> To be able to approve a request, you should sign in with a global administrator role.

## Locate the requests in the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com) as one of the registered reviewers of the admin consent workflow.
1. Select **All services** at the top of the left-hand navigation menu.
1. In the filter search box, type and select **Azure Active Directory**.
1. From the navigation menu, select **Enterprise applications**.
1. Under **Activity**, select **Admin consent requests**.
1. Select **My Pending** tab to view and act on the pending requests.
1. Select the application that is being requested from the list.

## View details of a request

Review details about the request:

- To view the application details, select the **App details** tab.
- To see who is requesting access and why, select the **Requested by** tab.

   :::image type="content" source="../media/5-consent-request-details.png" alt-text="Screenshot of the admin consent requests details in the portal.":::

When you select an application, you'll be able to approve, block, or deny the admin consent requests for the selected application.

## Act on pending requests

**Approve the application** - Select **Review permissions and consent** under details to review the application’s permissions and grant admin consent. Granting admin consent to the application will add it to your tenant and all users will be able to access it unless you restrict access to the application. Only designated reviewers will be able to perform this action from the **My Pending** tab.

:::image type="content" source="../media/5-review-permissions-consent-prompt.png" alt-text="Screenshot of the permissions requested by application.":::

**Block the application** - The application will be added to your tenant with a disabled status. Users won't be able to use it or access it through their My Apps portal. Only designated reviewers will be able to perform this action from the **My Pending** tab, and only users with the permission to create service principals from the backing application can perform this action. The reviewer should provide a justification for blocking the application.

:::image type="content" source="../media/5-block-application.png" alt-text="Screenshot shows how to block application.":::

**Deny the admin consent request** - This action won't block or add the application to your tenant. The request will be ignored, but may return if another user requests access. Only designated reviewers will be able to perform this action from the **My Pending** tab. The request may still occur if a user makes a similar request. The reviewer should provide a justification for denying the application.

After the reviewer acts on the consent request, the requestor is notified of the status of their request via email.

If the reviewer approves the request, the users won't be required to consent to the application for the same permissions during their next sign-in.
