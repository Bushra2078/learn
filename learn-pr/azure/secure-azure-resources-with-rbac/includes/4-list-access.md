At First Up Consultants, you've been granted access to a resource group for the marketing team. You want to familiarize yourself with the Azure portal and see what roles are currently assigned.

## List role assignments for yourself

Follow these steps to see what roles are currently assigned to you.

1. Select Launch lab button above, then select Start lab. In the secondary popup, select Get Started.
1. In the lab instructions menu, select the **Resources** tab.

    ![Screenshot of Resources tab in lab instructions](../media/4-resources-tab.png)

1. Look for the Admin username like **LabAdmin-_XXXXXXX_** and the password.
1. Sign into Azure portal using the LabAdmin username and password.
1. Close the Welcome popup, and in the upper-right corner of the Azure portal, click the profile picture to open the profile menu.
1. Make sure you are signed in as the **LabAdmin-_XXXXXXX_** that was identified in the lab instructions Resources tab. If you're signed in with a different account, sign out and sign in using the LabAdmin username and password on the Resources tab.

1. On the Profile menu, click the ellipsis (**...**) to see more links.

    ![Screenshot of user menu with My permissions highlighted.](../media/4-my-permissions-menu.png)

1. Select **My permissions** to open the My permissions pane.

    ![Screenshot of the My permissions pane.](../media/4-my-permissions-pane.png)

    On the My permissions pane, you can see the roles that you have been assigned and the scope. Your list will look different.

## List role assignments for a resource group

Follow these steps to see what roles are assigned at the resource group scope.

1. Select Home, and then under  **Azure services** select **Resource groups**.

   ![Screenshot of the Azure portal showing Azure services and recent resources.](../media/4-resource-groups.png)

1. Select the resource group  **FirstUpConsultantsRG1-_XXXXXXX_** and on the left menu pane, select **Access control (IAM)**.

   ![Screenshot showing Access control (IAM) option on the resource group pane.](../media/4-resource-group-access-control.png)

1. Select the **Role assignments** tab.

    This tab shows who has access to the resource group. Notice that some roles are scoped to **This resource** while others are **(Inherited)** from a parent scope.

   ![Screenshot showing Role assignments tab for the selected resource group.](../media/4-resource-group-role-assignment.png)

## List roles

As you learned in the previous unit, a role is a collection of permissions. Azure has over 70 built-in roles that you can use in your role assignments. Follow this step to list the roles.

- In the menu bar at the top of the pane, select **Roles** tab to list of all the built-in and custom roles.

   Select a role from this tab to display the number of users and groups assigned to that role.

   ![Screenshot showing a list of Roles and users and groups assigned to each role.](../media/4-roles-list.png)

In this unit, you learned how to list the role assignments for yourself in the Azure portal. You also learned how to list the role assignments for a resource group.