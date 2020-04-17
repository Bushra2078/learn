You now have a better understanding of device identity and conditional access. You want to investigate Azure Active Directory (Azure AD) join and how it might be used to improve device management for both Azure and on-premises Active Directory Domain Services.

In this unit, you'll learn about Azure AD join, and how to use it for infrastructure and device management.

## What is Azure AD join?

Azure AD join allows you to join devices to your Azure Active Directory organization, without needing to sync with an on-premises Active Directory instance. Azure AD join is best suited to organizations that are principally cloud based, although it can operate in a hybrid cloud and on-premises environment.

## Supported devices

Azure AD join works with Windows 10 or Windows Server 2019 devices. Windows Server 2019 Server Core installation isn't supported. If you're using an earlier Windows operating system, you'll need to upgrade to Windows 10 or Windows Server 2019.

## Identity infrastructure

Decide what identity infrastructure model best supports your organization's needs:

- **Managed environment**: This environment uses pass-through authentication or password hash sync to provide seamless single sign-on (SSO) to your devices.
- **Federated environments**: These environments require the use of an identity provider. That provider must support the WS-Trust and WS-Fed protocols for Azure AD join to work natively with Windows devices. WS-Fed is required to join a device to your Azure AD. WS-Trust is needed to sign in to an Azure AD joined device.
- **Smart cards and certificate-based authentication**: These methods aren't valid ways to join devices to Azure AD. But, if you have Active Directory Federation Services configured, you can use smart cards to sign in to Azure AD joined devices. We recommend that you use a service like Windows Hello for Business, which supports passwordless authentication to Windows 10 devices.
- **Manual user configuration**: If you create users in your on-premises Active Directory instance, you need to synchronize the accounts to Azure AD by using Azure AD Connect. If you create users in Azure AD, no additional setup is needed.

## Device management

Azure AD join uses the mobile device management (MDM) platform to manage devices attached to your Azure AD. MDM provides a means to enforce organization-required configurations like requiring storage to be encrypted, password complexity, software installations, and software updates.

The latest versions of Windows 10 now have a built-in MDM client that works with all compatible MDM systems.

To manage your Azure AD joined devices, there are two approaches:

- **MDM only**: All joined devices are managed exclusively through an MDM provider, like Intune. If your organization uses group policies, you'll need to review your MDM policy for support.

- **Co-management**: All joined devices use a combination of a locally installed System Center Configuration Manager agent and your MDM provider. Microsoft Intune provides co-management capabilities through Configuration Manager. You use Configuration Manager to manage the device while MDM delivers user management policies.

We recommend that you use the MDM-only approach to manage all Azure AD joined devices.

## Considerations for resources and application access

For the best user experience and to improve access to your application, consider moving all applications and resources to Azure. Although that might be possible in some cases, it isn't always practical. In this section, we'll explore access options for your applications and resources:

- **Cloud-based applications**: Any migrated apps and all new applications will be added to the Azure AD app gallery. Users of Azure AD join can use SSO to access those applications. The majority of browsers support SSO. Azure AD join provides SSO support for device access to applications still using Win32.

- **On-premises web applications**: Any bespoke or custom-made software that's hosted on-premises can still be accessed through Azure AD join. Access to those applications needs each user to add the app to their trusted sites or intranet zone, depending on where the app exists. This action allows the application to use Windows-integrated authentication without prompting the user to authenticate.

- **Other devices**: This option includes existing applications through earlier protocols, and on-premises network shares. Both are available to Azure AD joined devices through SSO, if the device is connected to your domain controller.

- **Printer resources**: These resources won't automatically be available through Azure AD join. Users can still connect to a printer directly, by using its UNC path.

## Provisioning options

When you're deploying Azure AD join, you have several choices for how devices are provisioned and joined to Azure AD. Three approaches are available:

- **Self-service**: Requires users to manually configure the device during the Windows out-of-box experience (OOBE) for new devices, or by using the Windows settings for older devices. Self-service is better suited to users who have a strong technical background.

- **Windows Autopilot**: Allows you to preconfigure Windows devices, including automatically joining the device to your Active Directory organization, automatic MDM enrollment, and creating customer OOBE content. This approach simplifies the management and deployment of devices across your organization. The Windows device can be provisioned and deployed. The user completes the OOBE as if they're a new user.

- **Bulk enrollment**: Lets you set up a provisioning package that applies to a large number of new Windows devices at the same time.

The following table shows the key features of each approach:

| Feature | Self-service | Windows Autopilot | Bulk enrollment |
| ---- | ---- | ---- | ---- |
| User interaction during setup | Yes | Yes | No |
| IT involvement | No | Yes | Yes |
| Applicable flows | OOBE and settings | OOBE only | OOBE only |
| Local admin rights to primary user | Yes | Configurable | No |
| Required OEM support | No | Yes | No |

## Device settings

In the Azure portal, you control how new devices are joined to your organization. Go to **Azure Active Directory**> **Devices** > **Device settings**. From there, you can configure the following features and turn on Azure AD join.

>[!div class="mx-imgBorder"]
>![Screenshot of the Azure AD device settings.](../media/3-device-settings.png)


|Field  |Description  |
|---------|---------|
|Users may join devices to Azure AD   |  **All** allows for any user to join their device. **Selected** allows you to add specific users that can join devices. **None** prevents all users from joining their devices.     |
|Additional local administrators on Azure AD joined devices     | Lets you specify other users to be included as local administrators on all joined devices. By default, this option is enabled. Azure AD adds the global administrator and device administrator roles as local administrators on device. |
|Users may register their devices with Azure AD|Allows users to register their devices with Azure AD join. If you're using Microsoft Intune or mobile device management for Office 365, device registration is required. If either of these services is configured in your Azure AD organization, **All** is selected and this option is disabled.|
|Require Multi-Factor Authentication to join device |  Lets you enforce Azure Multi-Factor Authentication when the device joins Azure AD. For the users who join devices to Azure AD by using Multi-Factor Authentication, the device itself becomes a second factor.   |
|Maximum number of devices per user| Lets you specify the maximum number of devices a user can have in Azure AD. If they reach this maximum, the user needs to remove a device to add a new one. |

For our scenario, we can add a pilot group of users to try AD join. In that case, choose **Users may join devices to Azure AD** > **Selected**, and then add members of your pilot group. When you're ready to deploy Azure AD join to your entire Azure AD organization, select **All**.

## Mobility settings

You might need to add an MDM provider before you can configure mobility settings. To add your MDM provider, go to **Azure Active Directory** > **Mobility (MDM and MAM)** > **Add application**.

>[!div class="mx-imgBorder"]
>![Screenshot that shows mobility applications you can add, like Microsoft Intune.](../media/3-mobility-add-application.png)


When you have your MDM provider added, you can configure the following mobility settings:

|Mobility setting  |description  |
|---------|---------|
|MDM user scope    |  Select **None**, **Some**, or **All**.  If the user *is* in the MDM scope and you have an Azure AD Premium subscription, MDM enrollment is automated along with Azure AD join. All users within the scope must have an appropriate license for your MDM. If not, the MDM enrollment fails and Azure AD join is rolled back. If the user *isn't* in the MDM scope, Azure AD join completes without any MDM enrollment. The device is an unmanaged device.  |
|MDM URLs    | The three URLs related to your MDM configuration are **MDM terms of use URL**, **MDM discovery URL**, and **MDM compliance URL**. Each URL has a predefined default value. If these fields are empty, contact your MDM provider for more information.    |
|MAM settings     |  Mobile Application Management (MAM) does not apply to Azure AD join.       |


Recall that you need to restrict access to the organization's resources to only those devices managed by your organization and considered compliant by your MDM system. So for our scenario, we'd want to add our organizations MDM provider and select the **MDM user scope** > **All**. 

## User experience when joining a Windows 10 device

You've given a new device to a tech-savvy employee. They'll use the self-service approach to join the device to your Active Directory organization, which is using Multi-Factor Authentication. The following steps show you what that workflow looks like.

1. After starting the device, they follow the prompts to set it up, including customizing their region and selecting a language.

    >[!div class="mx-imgBorder"]
    >![Screenshot of the region customization for Windows 10.](../media/3-walk-setup-pc.png)

1. Accept the Microsoft Software Licensing Terms.
1. Select the network connection to use to connect to the cloud.
1. When asked **Who owns this PC?**, select **This device belongs to my organization**.

    >[!div class="mx-imgBorder"]
    >![Screenshot that shows the who owns this pc prompt.](../media/3-walk-who-owns.png)

1. Employee signs in with the credentials supplied by your organization.
1. The employee is prompted with a multi-factor authentication challenge.
1. Azure AD checks the configuration settings to see if the device should be enrolled in MDM.
1. When successful, the device is registered with the organization's Azure AD. If MDM is being used, the device is enrolled and managed.

