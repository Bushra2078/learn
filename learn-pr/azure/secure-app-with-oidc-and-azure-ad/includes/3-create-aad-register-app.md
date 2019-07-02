Suppose you have decided to use OpenID Connect with your transportation company's app to allow users to authenticate by using the same credentials they use to access Office 365, which are stored in Azure AD. What's required to set this up properly? Let's look at the resources and configuration you'll need to make this happen.

## Create an Azure AD tenant

A tenant is an instance of Azure AD that is a representation of an organization. It's a dedicated instance of Azure AD that an organization or app developer receives when the organization or app developer creates a relationship with Microsoft, like signing up for Azure, Microsoft Intune, or Microsoft 365.

Each Azure AD tenant is distinct and separate from other Azure AD tenants and has its own representation of work and school identities, and app registrations. An app registration inside of your tenant can allow authentications from accounts only within your tenant or all tenants.

Azure AD tenants are created in the .onmicrosoft.com domain by default. You can't delete or change this name, but you can add your own registered domain name, and then create users and app registrations within that domain.

Azure AD tenants can only be created in the Azure portal.

## How to register a web app

Within the Azure tenant, you will need a registration for the application. The registration is a record of security details for the application in Azure AD. A registration ensures that Azure AD can identify the application as well as the user. A registration includes these details:

- **Name**. This value identifies the registration and application.
- **Application type**. Use the **Web app/API** type for web sites or web APIs that are accessed through the HTTP protocol. Use the **Native** type for applications that are installed on a user's device or computer.
- **Sign-on URL**. This value is the location of the sign-on page in the published application.
- **Application ID**. This generated GUID is unique to the registration. Configure your application to send the same GUID to Azure AD whenever it authenticates a user.

Application registrations are configured in the Azure portal. Applications are registered on the **App registrations > New application registration** page for the Azure AD tenant.

## How to configure the app for authentication

There is a lot of intricacy in ensuring the OpenID Connect protocol specifications are followed properly. To make it easy for developers to use OpenID Connect in their applications, Microsoft provides middleware to facilitate this communication. This middleware consists of APIs that include methods and properties that make it easy to interact with the identity provider. The middleware is available for several different platforms. Microsoft supplies and supports middleware libraries for .NET Framework, .NET Core, and Node.js. There are also client-side libraries for JavaScript, Angular, PHP, and other platforms.

For example, if you have an ASP.NET Core web app, you can add the `Microsoft.AspNetCore.Authentication.OpenIdConnect` NuGet package. Add the following values to the web.config file:

- `ida:Tenant`. This configuration value is the identity of the Azure AD directory that contains the application registration.
- `ida:ClientId`.  This configuration value is the GUID that uniquely identifies the client registration.

Then, configure the OpenID Connect middleware in the `Startup.ConfigureServices` method:

```c#
 services.AddAuthentication(sharedOptions =>
            {
                sharedOptions.DefaultScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                sharedOptions.DefaultChallengeScheme = OpenIdConnectDefaults.AuthenticationScheme;
            })
            .AddOpenIdConnect(options => Configuration.Bind("OpenId", options))
            .AddCookie();
```

You can use the the OpenID Connect ASP.Net OWIN middleware to sign in users from a single Azure AD tenant. The middleware is initialized in the Startup.Auth.cs file, by passing it the Client ID of the application and the URL of the Azure AD tenant where the application is registered. The middleware then takes care of:

- Downloading the Azure AD metadata
- Processing OpenID Connect authentication responses
- Integration with the session cookie
