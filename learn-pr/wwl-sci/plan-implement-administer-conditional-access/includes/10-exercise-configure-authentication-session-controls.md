## Configure sign in frequency controls using a conditional access policy

1.  Sign in to the [Azure portal](https://portal.azure.com/) using a Global administrator account.
2.  Open the portal menu and then select **Azure Active Directory**.
3.  On the Azure Active Directory blade, under **Manage**, select **Security**.
4.  On the Security blade, in the left navigation, select **Conditional access**.
5.  On the top menu, select **New policy**.

:::image type="content" source="../media/conditional-access-new-policy-8437a9fa.png" alt-text="Screen image displaying the Conditional Access blade with New policy highlighted":::


6.  In the **Name** box, enter **Sign in frequency**.
7.  Under **Assignments**, select **Users and groups**.
8.  On the Include tab, select the **Users and groups** check box.
9.  In the Select pane, select your administrator account and then select **Select**.
10. Select **Cloud apps or actions**.
11. Verify **Cloud apps** is selected and then select **Select apps**.
12. In the Select pane, select **Office 365** and then select **Select**.
13. Under **Access controls**, select **Session**.
14. In the **Session** pane, select **Sign-in frequency**.
15. In the value box, enter **30**.
16. Select the units menu, select **Days**, and then select **Select**.
17. Under **Enable policy**, select **Report-only**, and then select **Create**.

:::image type="content" source="../media/create-session-conditional-access-policy-4e0c98ea.png" alt-text="Screen image displaying a new conditional access policy with policy settings highlighted":::


> [!NOTE]
> Report-only mode is a new Conditional Access policy state that allows administrators to evaluate the impact of Conditional Access policies before enabling them in their environment. With the release of report-only mode:

 -  Conditional Access policies can be enabled in report-only mode.
 -  During sign-in, policies in report-only mode are evaluated but not enforced.
 -  Results are logged in the Conditional Access and Report-only tabs of the Sign-in log details.
 -  Customers with an Azure Monitor subscription can monitor the impact of their Conditional Access policies using the Conditional Access insights workbook.
