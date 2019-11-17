Suppose you've been asked to display your retail organization's branding to the Azure sign-in page to reassure users that they are passing credentials to a legitimate system.

Here, you'll learn how to configure this custom branding.

To complete this exercise, you must have two image files:
 - A page background image. This must be a PNG or JPG files, 1920 x 1080 pixels, and smaller than 300 KB.
 - A company logo image. This must be a PNG or JPG files, 280 x 60 pixels, and smaller than 10 KB.

## Customize Azure AD organization branding

Let's use Azure Active Directory (Azure AD) to set up the custom branding.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account you used to activate the sandbox.
1. Go to your Azure AD organization by selecting **Azure Active Directory**. If you're not in the right Azure AD organization, go to your Azure profile on the top right-hand side and select **Switch directory** to find your organization.
1. Under **Manage**, select **Company branding** > **Configure**.
1. Next to **Sign-in page background image**, select **Browse** button. Select your page background image.
1. Next to **Banner logo**, select **Browse**. Select your logo image.

    ![Screenshot that shows the configure company branding form](../media/5-customize-ui.png)
1. Select **Save**.

## Test organization's branding

Now, let's use the account that we created in the last exercise to test the branding.

1. In a new browser window, go to **https://login.microsoft.com**.
1. Select the account for **Bala Sandhu**. Your custom branding is displayed.

    ![Screenshot that shows the customized sign-in page](../media/5-custom-login-page.png)
1. Select **Forgot my password**.


    ![Screenshot that shows organization logo on password reset page](../media/5-forgot-password-branding.png)