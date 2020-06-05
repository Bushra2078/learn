Microsoft Endpoint Manager allows you to manage and secure your organization's cloud and on-premises devices, apps, and data. As part of this management, you can use Endpoint Manager to protect data, manage assignments, ensure proper access, implement security rules, and resolve compliance issues. Let's explore each of these concepts.

## Manage and secure devices

Before you can safeguard the devices that access your organization's resources, you must enroll them. Enrolling means that the device is connected and recognized by Intune or Configuration Manager based on a Mobile Device Management (MDM) certificate. There are several methods to enroll your workforce's devices. Each method depends on **device ownership** (personal or corporate), **device type** (iOS/iPadOS, Windows, Android, macOS), and **device management requirements** (resets, affinity, locking). These methods are explained below.

> [!NOTE]
> Before a device is enrolled with Intune or Configuration Manager, you may need to provision the device. Provisioning is a process when your organization issues new or repurposed devices to individuals in your organization. As part of the process, the indivdual user signs in to the device and steps through the process of connecting to your organization. You can either enroll the devices with Intune or Configuration Manager during the provisioning process or after depending on your needs.

### Device ownership

You can allow device ownership to be corporate or personal. Corporate-owned devices (COD) include phones, tablets, and PCs owned by the organization and distributed to the workforce. COD enrollment supports scenarios like automatic enrollment, shared devices, or pre-authorized enrollment requirements. A common way to enroll CODs is for an administrator or manager to use the device enrollment manager (DEM). iOS/iPadOS devices can be enrolled directly through Apple's Automated Device Enrollment (ADE) tools. Devices with an international mobile equipment identifier (IMEI) number can also be identified and tagged as corporate-owned.

Personally owned devices are often referred to as Bring your own devices (BYOD). BYOD includes personally owned phones, tablets, and PCs. Users install and run the Company Portal app to enroll BYODs. The Company Portal is where users can do common tasks. Common task may include enrolling devices, installing apps, and locating your organization's information, such assistance details from your IT department. 

### Device type

The available device types that can be managed by Endpoint Manager include iOS/iPadOS, Windows, Android, and macOS. These device types are also know as platforms. Because each device type is different, each offers sightly different enrollment methods, devices settings, protection policy settings, configuration policy settings, custom policy settings, and remote actions.

### Device management requirements

As part of the enrollment process, your organization may require specific initial actions before a devices can connect to your organization to ensure protection and safe access. You can choose reset required, user affinity, and locked. **Reset required** will wipe the devices during enrollment. **User affinity** will associate each device with a user. **Locked** will prevent users from unenrolling their device. Based on these requirements and the device type, you can choose which enrollment methods are best for your organization. 

### Enrollment methods

Each device type (iOS/iPadOS, Windows, Android, macOS) provides a different set of enrollment methods. These methods range from users adding their own device, to using a special user account that's used to enroll and manage multiple corporate-owned devices. When a user adds their own device to Intune or Configuration Manager it is called bring your own device (BYOD). When you a special user account to enroll and manage multiple corporate-owned devices, you use the Device enrollment manager (DEM).

#### iOS/iPadOS and macOS enrollment methods

The following list provides the available enrollment methods:
- **BYOD** - *(iOS/iPadOS and macOS)* The Bring Your Own Device method allows your end-users to enroll their device using Intune. An Apple MDM Push certificate is required for Intune to manage iOS/iPadOS and macOS devices. 
- **DEM** - *(iOS/iPadOS and macOS)* Device enrollment manager (DEM) is a special user account that's used to enroll and manage multiple corporate-owned devices. Managers can install the Company Portal and enroll many user-less devices. These types of devices are good for point-of-sale or utility apps, for example, but not for users who need to access email or company resources. 
- **ADE** - *(iOS/iPadOS and macOS)* Apple Automated Device Enrollment (ADE) management lets you create and deploy policy "over the air" to iOS/iPadOS and macOS devices that are purchased and managed with ADE. The device is enrolled when users turn on the device for the first time and run Setup Assistant (SA). This method supports iOS/iPadOS supervised mode, which enables a device to be configured with specific functionality.
- **USB-SA** - *(iOS/iPadOS)* IT admins use Apple Configurator, through USB, to prepare each corporate-owned device manually for enrollment using Setup Assistant. The IT admin creates an enrollment profile and exports it to Apple Configurator. When users receive their devices, they're then prompted to run Setup Assistant to enroll their device. 
- **USB-Direct** - *(iOS/iPadOS)* For direct enrollment, the admin must enroll each device manually by creating an enrollment policy and exporting it to Apple Configurator. USB-connected, corporate-owned devices are enrolled directly and don't require a wipe. Devices are managed as user-less devices. They're not locked or supervised and can't support Conditional Access, jailbreak detection, or mobile application management.

#### Windows enrollment methods

The following list provides the available enrollment methods:
- **BYOD** - The Bring Your Own Device method allows your end-users to enroll their device using Intune. Bring your own devices (BYOD) include personally-owned phones, tablets, and PCs. Users install and run the Company Portal app to enroll BYODs. This program lets users access company resources like email.
- **DEM** - Device enrollment manager (DEM) is a special user account that's used to enroll and manage multiple corporate-owned devices. Managers can install the Company Portal and enroll many user-less devices. These types of devices are good for point-of-sale or utility apps, for example, but not for users who need to access email or company resources. 
- **Auto-enroll** - Automatic enrollment lets users enroll their Windows 10 devices in Intune. To enroll, users add their work account to their personally owned devices or join corporate-owned devices to Azure Active Directory. In the background, the device registers and joins Azure Active Directory. Once registered, the device is managed with Intune.
- **Autopilot** - Windows Autopilot simplifies enrolling devices in Intune. You provide the enrollment details up front before the end user receives a new computer. The Windows Autopilot process runs immediately after powering on a new computer for the first time, enabling employees to configure new devices to be business-ready with just a few clicks. 
- **Bulk enroll** - To bulk enroll devices for your Azure AD tenant, you create a provisioning package with the Windows Configuration Designer (WCD) app. Applying the provisioning package to corporate-owned devices joins the devices to your Azure AD tenant and enrolls them for Intune management. Once the package is applied, it's ready for your Azure AD users to sign in.
- **Co-management** - Co-management is where you concurrently manage Windows 10 devices with both Configuration Manager and Microsoft Intune. It combines your existing on-premises Configuration Manager investment with the cloud using Intune and other Microsoft 365 cloud services. You choose whether Configuration Manager or Intune is the management authority. You keep some tasks on-premises, while running other tasks in the cloud with Intune.
- **GPO** - You can use a Group Policy (GPO) to trigger auto-enrollment to MDM for Active Directory (AD) domain-joined devices. The enrollment into Intune is triggered by a group policy created on your local AD and happens without any user interaction. This means you can automatically mass-enroll a large number of domain-joined corporate devices into Microsoft Intune. The enrollment process starts in the background once you sign in to the device with your Azure AD account.

#### Android enrollment methods

The following list provides the available **personal** enrollment methods:
- **BYOD** or **Corporate Owned** - End-users enroll their personal or corporate-owned Android device using the Company Portal app to get secure access to company email, apps, and data. 
- **Android Enterprise Work Profile** - During enrollment, you set up Android Enterprise work profile management. Then, you tell your users how to enroll their devices using the Company Portal app. Android Enterprise work profile separates the personal data on an end-user's device from their work files and data. Your organization manages the work profile, but cannot manage the personal data on the end-user's device. 

The following list provides the available **corporate** enrollment methods:
- **DEM** - Enroll devices in Intune by using a device enrollment manager (DEM) account and the Company Portal. DEM is an Intune permission that can be applied to an AAD user account and lets the user enroll up to 1,000 devices. A DEM account is useful for scenarios where devices are enrolled and prepared before handing them out to the users of the devices. By design, there's a limit of 150 Device Enrollment Manager (DEM) accounts in Microsoft Intune.
- **Pre-declared IMEI or SN** - Enroll corporate owned devices in Intune based on a international mobile equipment identifier (IMEI) number or serial number (SN).
- **User or DEM on Zebra devices** - Enroll corporated owned devices in Intune using Android device administrator. For devices manufactured by Zebra Technologies, you may need to grant the Company Portal additional permissions depending on the capabilities of the specific device. 
- **NFC, Token, QR code, Zero Touch on Android Enterprise Dedicated** - Android Enterprise supports corporate-owned, single-use, kiosk-style devices with its dedicated devices solution set. Devices that you manage in this way are enrolled in Intune without a user account and aren't associated with any end user. They're not intended for personal use applications or apps that have a strong requirement for user-specific account data such as Outlook or Gmail. Intune enrollment for dedicated devices starts with a factory reset. How you enroll your Android Enterprise devices depends on the operating system.
- **NFC, Token, QR code, Zero Touch on Android Enterprise Fully Managed** - Android Enterprise fully managed devices are corporate-owned devices associated with a single user and used exclusively for work and not personal use. Admins can manage the entire device and enforce policy controls unavailable to work profiles. Intune enrollment for fully managed devices starts with a factory reset. How you enroll your Android Enterprise devices depends on the operating system.

### Enrollment options

Intune admins can configure device enrollment to help users and enable Intune capabilities. Intune includes the following enrollment options:
- Terms and conditions - Optionally require that users accept your company's terms and conditions before they can enroll their devices and access resources like company apps and email. 
- Enrollment restrictions - Restrict device enrollment by device platform, number of devices per user, or block personal devices.
- Enable Apple device enrollment - An MDM push certificate is required for iOS/iPadOS and macOS device enrollment.
- Corporate identifiers - List international mobile equipment identifier (IMEI) numbers and serial numbers to identify corporate-owned devices.
- Multi-factor authentication - Require users to use an additional verification method, such as a phone, PIN, or biometric data, when they enroll a device. 
- Device enrollment manager - Make users device enrollment managers (DEM). DEM users can enroll large numbers of mobile devices with a single user account. 
- Device categories - Use device categories to automatically add devices to groups based on categories that you define. Organizing devices into groups makes it easier for you to manage those devices. 

## Manage and secure apps and email

Safeguard the devices and apps that access your organization resources.

## Ensure proper rights and access
Ensure your organization is using proper credentials to access and share company data.

## Protect your organization’s data

Protect the data that the people at your organization are accessing.


## Provide device, app, and policy management based on groups

Manage assignments of devices, apps, and policies.

## Implement security rules

Confirm security rules are in place based on your organizations requirements.

## Analyze and resolve compliance issues


 
