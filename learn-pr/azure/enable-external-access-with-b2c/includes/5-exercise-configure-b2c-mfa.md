You've been asked to integrate your healthcare application with Azure AD B2C. Azure AD B2C must handle all the patients' registration and sign-in processes for the application. Any user who attempts to access the healthcare application must also be challenged with multi-factor authentication.

You'll now create a B2C tenant, register an application, and put together a sign-up and sign-in user flow. You'll enable multi-factor authentication to take advantage of its protection. Also, you'll test patients' user experience by doing test runs for the user flow.

## Create your Azure AD B2C tenant

First, you create an Azure AD B2C tenant.

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal as a global administrator. If you're the person who signed up for the Azure account, you'll be the global administrator.
1. Make sure you're in the directory that holds your subscription by selecting the **Directory + subscription** filter at the top of the Azure portal. Select your directory.

    ![Select a tenant](../media/5-select-directory.png)

1. Create a new resource by selecting **Create a resource** on the left of the Azure portal. Search for **Active Directory B2C**, select the search result, and then select **Create**.

    ![Create a B2C resource](../media/5-create-b2c-resource.png)

1. Select  **Create a new Azure AD B2C Tenant**. Fill in the form then select **Create**

    ![Create tenant form ](../media/5-create-tenant-form.png)

1. Select the link at the top of your form then select **Link an existing Azure AD B2C Tenant to my Azure subscription**.

    ![Select tenant link](../media/5-select-tenant-link.png)

    ![Link an existing tenant to your subscription](../media/5-link-existing-tenant.png)
1. For the **Azure AD B2C Tenant** field, select the tenant you created. Create a new resource group for your tenant using the **Create new** link under the **Resource Group** field. Select a location for your resource group in the **Resource group location** field.

    ![Link existing tenant form](../media/5-link-existing-tenant-form.png)

1. Select **Create**, then switch to your newly created tenant. Select the **Directory + subscription** filter at the top of the portal then select your tenant. You might have to refresh your browser to see the new tenant.

    ![Switch to your new tenant](../media/5-switch-tenant.png)

## Register your application

You need to register your application.

1. Select **All services**, then search for **Azure AD B2C**, and select the top search result.

    ![Search for AD B2C in all services](../media/5-all-services.png)

1. Select **Applications > Add**.

    ![Add application](../media/5-add-application.png)

1. In the form, provide a **Name** for your application. Select **Yes** for **Include web app/web API**, and select **Yes** for **Allow implicit flow**.

    ![The form that adds your application](../media/5-add-application-form.png)
1. For the **Reply URL**, use `https://jwt.ms`. It points to a test web app. The app shows the data that's collected and returned to the user.

1. Select **Create**.

## Create user flow

You'll create a user flow that lets your users sign up, and sign in to your application.

1. Go back to your Azure AD B2C. Select **All services**, look for Azure AD B2C, and select the top search result.

1. Select  **User flows(policies) > New user flow**.

    ![Add a user flow](../media/5-add-user-flow.png)

1. Select the **Sign up and sign in** user flow.

    ![Select a user flow](../media/2-select-user-signin-flow.png)

1. In the form that appears, give your user flow a name. Select **Email signup** in the **Identity providers** section. At this point, you could enable multi-factor authentication. However, we'll do it later to show how you can enable multi-factor authentication on existing user flows.

    ![Configure your user flow](../media/5-create-user-flow.png)

1. In the **User attributes and claims** section, select the attributes you want to collect from the user at sign-up, and what you want to return to them at sign-in. For this exercise, you'll select **Given Name**, **Surname**, and **Country/Region**.

1. Select **Create**.

## Enable multi-factor authentication

You can enable multi-factor authentication when you create a user flow. But you can also enable and disable multi-factor authentication on a user flow you've already created.

1. Select **User flows (policies)**, then select your user flow.

    ![Select your user flow](../media/5-edit-user-flow.png)

1. Select **Properties**, then select **Enabled** under **Multifactor authentication**.

    ![Enable MFA](../media/5-enable-mfa.png)

1. Select **Save**.

## Test the user experience

You now test the user flow to try the experience from the user's perspective.

### Test the sign-up process

1. Select **overview > Run user flow**.

    ![Test user flow](../media/5-run-user-flow.png)

1. Select **Run user flow** in the form that appears.

    ![The form you use to run your user flow](../media/5-run-user-flow-form.png)

1. Select **Sign up now** in the form that appears in the new tab or window.

    ![Select sign-up](../media/5-select-signup.png)

1. Fill in the sign-up form that appears.

    ![Sign up form](../media/5-signup-form.png)

1. Enter a number for multi-factor authentication and select a method to receive the code.

    ![Configure MFA details](../media/5-configure-mfa-enter-number.png)

1. When your authentication code is verified, your account will be created. You're forwarded to the test app at `https://jwt.ms`. The test app shows all the claims you chose to return to the application when you configured the user flow.

    ![Claims returned](../media/5-claims-returned.png)

### Test the sign-in process

1. Run the user flow again by following step 1 and step 2 from the previous section. The sign-in form will appear.

1. Fill in the sign-in form.

    ![Sign-in form](../media/5-signin-form.png)

1. Complete the multi-factor authentication challenge that follows.

    ![MFA for sign-in](../media/5-mfa-for-signin.png)

1. When you've been authorized, you'll be forwarded to the test app again.
