Conditional Access is an Azure Active Directory capability that is included with an Azure Active Directory Premium license. Intune enhances this capability by adding mobile device compliance and mobile app management to the solution. 

![Intune and Conditional Access when using EMS](../media/intro-to-endpoint-manager-05.png)

Ways to use Conditional Access with Intune:

- **Device-based Conditional Access**
  - Conditional Access for Exchange on-premises
  - Conditional Access based on network access control
  - Conditional Access based on device risk
  - Conditional Access for Windows PCs
    - Corporate-owned
    - Bring your own device (BYOD)
- **App-based Conditional Access**

With co-management, Intune evaluates every device in your network to determine how trustworthy it is. It does this evaluation in the following two ways:

1. Intune makes sure a device or app is managed and securely configured. This check depends on how you set your organization's compliance policies. For example, make sure all devices have encryption enabled and aren't jailbroken.  

    - This evaluation is pre-security breach and configuration-based  

    - For co-managed devices, Configuration Manager also does configuration-based evaluation. For example, required updates or apps compliance. Intune combines this evaluation along with its own assessment.  

2. Intune detects active security incidents on a device. It uses the intelligent security of Microsoft Defender Advanced Threat Protection (formerly Windows Defender ATP) and other mobile threat defense providers. These partners run ongoing behavioral analysis on devices. This analysis detects active incidents, and then passes this information to Intune for real-time compliance evaluation.  

    - This evaluation is post-security breach and incident-based  


By using Intune or Configuration Manager, you help ensure your organization is using proper credentials to access and share company data.

## Common ways to use Conditional Access

There are two types of conditional access with Intune: device-based conditional access and app-based conditional access. You need to configure the related compliance policies to drive conditional access compliance at your organization. Conditional access is commonly used to do things like allow or block access to Exchange, control access to the network, or integrate with a Mobile Threat Defense solution.
 
### Device-based Conditional Access

Intune and Azure Active Directory work together to make sure only managed and compliant devices can access email, Office 365 services, Software as a service (SaaS) apps, and [on-premises apps](https://docs.microsoft.com/azure/active-directory/active-directory-application-proxy-get-started). Additionally, you can set a policy in Azure Active Directory to only enable domain-joined computers or mobile devices that are enrolled in Intune to access Office 365 services.

Intune provides device compliance policy capabilities that evaluate the compliance status of the devices. The compliance status is reported to Azure Active Directory that uses it to enforce the Conditional Access policy created in Azure Active Directory when the user tries to access company resources.

### Conditional access based on network access control

Intune integrates with partners like Cisco ISE, Aruba Clear Pass, and Citrix NetScaler to provide access controls based on the Intune enrollment and the device compliance state.

Users can be allowed or denied access to corporate Wi-Fi or VPN resources based on whether the device they're using is managed and compliant with Intune device compliance policies.

### Conditional access based on device risk

Intune partners with Mobile Threat Defense vendors that provide a security solution to detect malware, Trojans, and other threats on mobile devices.

#### How the Intune and Mobile Threat Defense integration works

When mobile devices have the Mobile Threat Defense agent installed, the agent sends compliance state messages back to Intune reporting when a threat is found on the mobile device itself.

The Intune and mobile threat defense integration plays a factor in the conditional access decisions based on device risk.

### Conditional access for Windows PCs

Conditional access for PCs provides capabilities similar to those available for mobile devices. Let's talk about the ways you can use conditional access when managing PCs with Intune.

#### Corporate-owned

- **Hybrid Azure AD joined:** This option is commonly used by organizations that are reasonably comfortable with how they're already managing their PCs through AD group policies or Configuration Manager.

- **Azure AD domain joined and Intune management:** This scenario is for organizations that want to be cloud-first (that is, primarily use cloud services, with a goal to reduce use of an on-premises infrastructure) or cloud-only (no on-premises infrastructure). Azure AD Join works well in a hybrid environment, enabling access to both cloud and on-premises apps and resources. The device joins to the Azure AD and gets enrolled to Intune, which can be used as a conditional access criteria when accessing corporate resources.

#### Bring your own device (BYOD)

- **Workplace join and Intune management:** Here the user can join their personal devices to access corporate resources and services. You can use Workplace join and enroll devices into Intune MDM to receive device-level policies, which are another option to evaluate conditional access criteria.

## App-based conditional access

Intune and Azure Active Directory work together to make sure only managed apps can access corporate e-mail or other Office 365 services.