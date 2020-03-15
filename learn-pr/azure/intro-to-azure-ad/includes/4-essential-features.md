Your company wants to improve how it provides services to doctors and how it collaborates with external healthcare organizations. You've been asked to investigate what other capabilities and services Azure AD could provide for the organization.

Here, you explore some essential features of Azure AD and how you can use them. For example, you look at features like Azure Active Directory B2B (Azure AD B2B), Azure Active Directory B2C (Azure AD B2C), Azure AD Domain Services, and Azure Identity Protection. You see which features you can use to help improve how you manage applications in Azure AD.

## Azure AD B2B

Use Azure AD to invite external users to your tenant. Your organization can then collaborate with external healthcare partner staff members through Azure AD B2B Collaboration. 

For example, your company works with external healthcare partners. These partners can be invited as guest users to your tenant. When their work is done, you can revoke access for those external partners until it's needed again.

Here's the B2B collaboration process:

![B2B collaboration process](../media/4-b2b-process.svg)

1. The external user either receives an email invitation that includes a redemption link or gets a direct link.
1. The user selects the redemption link to access the applications they were invited to.
1. If multi-factor authentication is set up, the user receives a verification code on their phone.
1. The user provides the code they received.
1. The user can access the application, whether it's on-premises or in the cloud.

This feature is available for all licensing tiers in Azure AD.

## Azure AD B2C

You can also use Azure AD B2C to manage your customers' identities and access. Your doctors' accounts should have protected access to resources and services. Use Azure AD B2C to securely authenticate the doctors through their preferred identity providers. 

AD B2C also helps you monitor for threats like brute force attacks and denial-of-service attacks on doctors' user accounts. To use Azure AD B2C, you register your applications. You then configure user flows to set up the user's journey to access an application.

For example, a flow for the sign-in process might go like this:

![Sign-in flow for users](../media/4-signin-user-flow.svg)

1. On their browser or mobile phone, the user goes to the application they want to access.
1. The user is required to complete the sign-in form.
1. If the credentials are verified and multi-factor authentication is enabled, the user receives a verification code on their phone.
1. The user provides the code they received.
1. The user is granted access to the application.

This feature is available on a pay-as-you-go basis.

## Azure AD Domain Services

Azure AD Domain Services (Azure AD DS) lets you add virtual machines to a domain without needing domain controllers. Your internal staff users can access virtual machines by using their company Azure AD credentials. 

Use this service to reduce the complexity of migrating on-premises applications to Azure. An organization could also use Azure AD DS to handle its infrastructure if it runs applications both on-premises and in the cloud. The process might go like this:

![Process for adding VMs to a domain in Azure AD DS](../media/4-azure-ad-domain-services.svg)

1. The organization deploys its applications and servers in a virtual network on Azure.
1. Azure AD Connect sync synchronizes identity information between the on-premises Active Directory instance and the organization's tenant in Azure AD.
1. The company enables Azure AD DS on their Azure AD tenant.
1. The applications and servers in Azure can use features like domain joining and Kerberos authentication.

This feature is available for pay-as-you-go, based on the total number of objects in your domain that's managed by Azure AD DS. Objects can include users, groups, and domain-joined computers.

## Application management

Your company might provide many applications that internal and external users rely on. Users might want to access these applications from different devices and locations. You can use Azure AD as a cloud-based solution to manage user access for all of these applications.

You can manage different categories of applications in Azure AD:

- **Azure AD App Gallery applications**. Thousands of SaaS applications are integrated with Azure AD. Find these applications in Azure Marketplace.

    ![Azure Marketplace](../media/4-azure-ad-marketplace.png)

- **Custom applications**. You can register your company-built applications with Azure AD. You then control and monitor authentication for these applications.

    ![Add a custom application](../media/4-applications.png)

- **Non-gallery applications**. You can manually add any applications that you don't see in the gallery.

    ![Add a non-gallery application](../media/4-non-gallery-applications.png)

- **On-premises applications**. You can add on-premises applications by configuring Azure AD Application Proxy. This process creates secure remote access for your on-premises applications. To connect them, download and install the Application Proxy connector on-premises.

    ![Add an on-premises application](../media/4-add-on-premises-application.png)

In the following sections, you learn about other Azure AD features that you can use to benefit your applications.

### Protect your apps through conditional-access policies

Use conditional-access policies to require users to pass additional authentication challenges before they access an application. For example, you can configure a conditional-access policy to require users to complete a multi-factor authentication challenge after their credentials are verified and before they access the application.

![Require multi-factor authentication in Azure AD](../media/4-conditional-access-policy.png)

Conditional-access policies are available for Premium P1 and Premium P2 license tiers.

### Monitor your application access

Azure AD can help monitor your application sign-ins by generating reports that cover sign-in dates, user details, applications the user has used, risk detection, location, and more. Access those reports through the Azure portal or specific APIs for programmatic usage.

![Azure AD reports](../media/4-reports.png)

Reports are available for all licensing tiers.

## Azure AD Identity Protection

Azure AD Identity Protection helps you to automatically detect, investigate, and remediate identity risks for users. Identity Protection also lets you export all the information that was collected about risks. Export the information to third-party tools and solutions so that you can further analyze it.

Identity Protection uses risk policies to automatically detect and respond to threats. You configure a risk policy to set up how Identity Protection should respond to a particular type of risk. Use policies in this way to save time and give you peace of mind.

![Identity Protection flow in Azure AD](../media/4-identity-protection-flow.svg)

By using automated risk detection and remediation through Identity Protection, the administrator first configures the risk policies. These policies then monitor for identity risks. When a risk is detected, the policies enforce measures to remediate it. For example, a policy might require a user to reset their password in response to a detected risk. The user then resets their password, and the risk is remediated.

You configure risk policies through the Azure portal. For example, the following risk policy detects user risks and remediates them by requiring the user to reset their password.

![Risk policy in Azure AD Identity Protection](../media/4-risk-policy.png)

Identity Protection is available for the Premium P2 licensing tier.
