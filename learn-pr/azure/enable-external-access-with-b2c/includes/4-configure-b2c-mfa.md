You have a healthcare web application that handles sensitive patient data. The app must remain secure, even if a patient's user name or password is compromised. You'll need to configure Azure Active Directory B2C (Azure AD B2C) with multi-factor authentication to protect patients' access to the application. 

You'll configure components for your healthcare application to take advantage of the combined benefits of Azure AD B2C and multi-factor authentication. You'll need to configure a tenant, register your application, and create a user flow.

## Configure Azure AD B2C and multi-factor authentication for your application

This section explains the main configuration steps.

### Create a tenant

First, you must register your app with an Azure AD B2C tenant before it can work with Azure AD B2C. To do this, you'll need to create a new Azure AD B2C tenant.

Use the Azure portal to create an Azure AD B2C tenant as a resource. Specify a name, domain, and region for your tenant:

![Azure AD B2C Create Tenant form](../media/4-create-tenant.png)

An Azure AD B2C tenant isn't the same as an Azure Active Directory (Azure AD) tenant. You use an Azure AD tenant to represent an organization. Your Azure AD B2C tenant represents the identities that are used for customer applications.

When you create a new Azure AD B2C tenant, you'll see it in your list of directories in the portal:

![View your new Azure AD B2C tenant](../media/4-created-b2c-tenant.png)

You switch to your new Azure AD B2C tenant to register it with your application.

### Register your application

When you've switched to the new Azure AD B2C tenant, you can register the application. Go to the Azure AD B2C resource you've created:

![Register an application](../media/4-azuread-b2c-register-application.png)

There's a form to register your application. Provide the name of your application and specify whether it's a web app or a web API. Also, you must indicate whether it's a native application, such as for desktops, versus a mobile app.

![New application form](../media/4-register-application-form.png)

Your health application is a web app, so you'll need to provide a *reply URL*. The reply URL is the endpoint where your Azure AD B2C will send tokens for the application requests. You can also use a local URL like `https://localhost:{port}`. Your reply URL, which is case sensitive, is valid only if it begins with `https`.

### Create user flows

You use user flows to manage things like sign-ins and sign-ups. Your Azure AD B2C tenant lets you create multiple types of user flows:

![Create user flows](../media/4-create-user-flows.png)

Create a user flow for sign-ups and sign-ins for your users. You use the **Sign-up and sign-in** user flow to handle the steps for users to create an account for the app and to access the app. This user flow guides users through several pages that help them sign in or sign up.

Use this form to create the user flow:

![Create a sign-up user flow](../media/4-create-sign-up-flow.png)

When you create a **Sign-up and sign-in** user flow, you'll specify a name for it. You'll need to enable **Email sign-up** to successfully create your user flow. In the **Multifactor authentication** section, you can enable multi-factor authentication or keep it disabled and return to it later. In the **User attributes and claims** section, specify which information to collect from the user. You'll also choose which claims about the user to return to the application. Claims are the same attributes collected earlier by the application, about the user, during sign-up. You're then ready to create your sign-up and sign-in user flow.

### Enable multi-factor authentication

As you've already seen, you enable multi-factor authentication for a user flow when you create one. You can also return to previously created user flows and retroactively enable or disable multi-factor authentication. To do that, go to your existing user flow and use the **Multifactor authentication** toggle:

![Enable multi-factor authentication](../media/4-enable-mfa.png)

## End-user experience

After your user flow and multi-factor authentication have been configured, the application is ready to use.

Because your healthcare application is a web app, the user accesses it through their browser. Users must sign up in your application if they don't already have an account. On the sign-up page, they're asked to provide the information you configured your user flow to collect. The sign-up form might look like this:

:::image type="content" source="../media/4-sign-up-form.png" alt-text="Sign-up form." loc-scope="azure-active-directory-b2c":::

You'll see that this form collects attributes like **Country/Region**, **Given Name**, and **Surname** from the user. The **Send verification code** button sends a verification code via email. The code is then used to complete registration.

When your user has registered an account, they sign in. The sign-in form might look like this:

:::image type="content" source="../media/4-sign-in-form.png" alt-text="Sign-in form." loc-scope="azure-active-directory-b2c":::

After their credentials have been verified, the user then completes a multi-factor authentication challenge. The user enters their phone number and chooses to receive a code via either text message or phone call.

![Multi-factor authentication form](../media/4-mfa-form.png)

When the user completes the challenge, they are signed in successfully. The claims that you selected about the user are returned to the application as shown in the following example. Your application uses these claims to understand the user who is interacting with it.

![Claims](../media/4-claims.png)