# Title

Secure your application with OpenID Connect and Azure AD

## Role(s)

- Solution Architect
- Developer

## Level

- Intermediate

## Product(s)

- Azure AD
- Azure App Service

## Prerequisites

- Basic knowledge of C#
- Basic knowledge of Azure AD

## Summary

Use OpenID Connect in your application to allow users to securely sign in with Azure AD identities.

## Learning objectives

1. Determine Authentication needs of your application
2. Create an Azure AD tenant and configure application registration for your application
3. Deploy an application that uses OpenID Connect to authenticate users

## Chunk your content into subtasks

Identify the subtasks of *Secure your application with OpenID Connect and Azure AD*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Determine authentication needs of your application | Business need to secure login | Knowledge check | 1 | Yes |
| Create an Azure AD tenant and configure application registration for your application | Business need to create Azure AD tenant | Exercise | 2 | Yes |
| Deploy an application that uses OpenID Connect to authenticate users| Business need to deploy | Exercise | 3 | Yes |

1. **Introduction**

    You work for a transportation company and are building an application that allows drivers to log in and manage their schedules. You want to allow users to log in with their Azure AD accounts that they currently use for Office 365 so they don't have to create additional accounts. You need to configure your application to allow authentication with OpenID Connect.

1. **Determine authentication needs of your application**

    - Authentication scenarios in Azure Active Directory
        - Example scenarios and details of it's relevance
    - OpenID Connect and OAuth 2.0
        - Features and concepts using this for authentication
    - Understanding Office 365 Identity and AD
        - Features and concepts using this for cloud authentication

1. **Knowledge check**
    - In which of the following scenarios would OpenID Connect be the best option?
    - What different modern app architectures are supported by Azure Active Directory (Azure AD) authentication?

1. **Create an Azure AD tenant and configure application registration for your application**
    - In order to integrate your app with the Azure Active Directory, you will need to register your application’s details with the active directory in the Azure portal. To do this, you need to first create an Azure Active Directory tenant (Check the upper right corner. If you have a tenant, you'll automatically be logged in and can see the tenant name directly under your account name.)

1. **Exercise - Create an Azure AD tenant and configure application registration for your application**
    1. Login to the Azure Portal
    1. Select Create a resource, select Identity, and then select Azure Active Directory
    1. Enter an Organization name, Initial domain name and Select the Country or region from the dropdown
    1. Once created, locally clone a sample .NET app from GitHub. Similar to https://github.com/Azure-Samples/active-directory-dotnet-webapp-openidconnect
    1. On the top bar, click on your account and under the Directory list, choose the Active Directory tenant where you wish to register your application.
    1. Click on All services in the left-hand nav, and choose Azure Active Directory.
    1. In the Azure Active Directory pane, click on App registrations and choose New application registration.
    1. Enter a friendly name for the application, for example 'WebApp-OpenIDConnect-DotNet' and select 'Web app / API' as the Application Type.
    1. For the sign-on URL, enter the base URL for the sample. By default, this sample uses https://localhost:44320/.
    1. Click Create to create the application.
    1. In the succeeding page, Find the Application ID value and record it for later. You'll need it to configure the Visual Studio configuration file for this project.
    1. Then click on Settings, and choose Properties.
    1. For the App ID URI, replace the guid in the generated URI 'https://<your_tenant_name>/<guid>', with the name of your service, for example, 'https://<your_tenant_name>/WebApp-OpenIDConnect-DotNet' (replacing <your_tenant_name> with the name of your Azure AD tenant)
    1. From the Settings | Reply URLs page for your application, update the Reply URL for the application to be https://localhost:44320/
    1. Configure Permissions for your application. To that extent, in the Settings menu, choose the 'Required permissions' section and then, click on Add, then Select an API, and type Windows Azure Active Directory in the textbox. Then, click on Select Permissions and select User.Read.

    In the following steps, you may need the tenant name (directory name) or the tenant ID (directory ID). These are in the Properties of the Azure Active Directory window respectively as Name and Directory ID

    In the steps below, "ClientID" is the same as "Application ID" or "AppId".

    1. Open the solution in Visual Studio to configure the projects
    1. Open the WebApp-OpenIDConnect-DotNet\Web.Config file
    1. Find the app key ida:Tenant and replace the existing value with your Azure AD tenant name.
    1. Find the app key ida:ClientId and replace the existing value with the application ID (clientId) of the  WebApp-OpenIDConnect-DotNet application copied from the Azure portal.
    If you changed the base URL of the sample, find the app key ida:PostLogoutRedirectUri and replace the value with the new base URL of the sample.

1. **Deploy an application that uses OpenID Connect to authenticate users**
    - Create and publish the WebApp-OpenIDConnect-DotNet to an Azure Web Site

1. **Exercise - Deploy an application that uses OpenID Connect to authenticate users**
    1. Sign in to the Azure portal.
    1. Click Create a resource in the top left-hand corner, select Web App, give your site a name (App name) such as, WebApp-OpenIDConnect-DotNet-contoso.azurewebsites.net, select the Subscription and Resource Group and Service plan/location, and Click Create.
    1. Once the web site is created, click on it to manage it. For this set of steps, download the publish profile by clicking Get publish profile and save it. Note: You can also use other deployment mechanisms such as from within Visual Studio by publishing.
    1. Switch to Visual Studio and go to the TodoListService project. Right click on the project in the Solution Explorer and select Publish. Click Import Profile on the bottom bar, and import the publish profile that you downloaded earlier.
    1. Click on Settings and in the Connection tab, update the Destination URL so that it is https, for example https://WebApp-OpenIDConnect-DotNet-contoso.azurewebsites.net. Click Next.
    1. On the Settings tab, make sure Enable Organizational Authentication is NOT selected. Click Save. Click on Publish on the main screen.
    1. Visual Studio will publish the project and automatically open a browser to the URL of the project. If you see the default web page of the project, the publication was successful.
    1. Run the web app
    1. Click the sign-in link on the homepage of the application to sign in. On the Azure AD sign-in page, enter the name and password of a user account that is in your Azure AD tenant.

1. **Summary**

   - Explored the OpenID Connect concepts for authentication
   - Created and deployed an application that uses OpenID Connect to authenticate users

## Notes

- This sample shows how to use the OpenID Connect ASP.Net OWIN middleware to sign in users from a single Azure AD tenant. The middleware is initialized in the Startup.Auth.cs file, by passing it the Client ID of the application and the URL of the Azure AD tenant where the application is registered. The middleware then takes care of:
    - Downloading the Azure AD metadata
    - Processing OpenID Connect sign-in responses
    - Integrating with the session cookie