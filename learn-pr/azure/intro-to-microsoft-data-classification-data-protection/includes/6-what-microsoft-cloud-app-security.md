As Contoso moves more services to the cloud, it increases flexibility for employees and IT alike. However, it also introduces new challenges and complexities for keeping their organization secure. To get the full benefit of cloud apps and services, you and your IT team must find the right balance of supporting access while maintaining control to help protect critical data. It's crucial to gain visibility and control of data in cloud applications, given the increasing number of cybersecurity attacks and compliance requirements with key regulations.

## What is Defender for Cloud Apps?

Microsoft Defender for Cloud Apps is a user-based subscription service that provides visibility and control over data travel and sophisticated analytics to identify and combat cyberthreats across all your cloud services. Defender for Cloud Apps is powered by native integrations with industry-leading security and identity solutions, including Azure Active Directory, Intune, and Azure Information Protection. Defender for Cloud Apps identifies and combats these threats by operating as an intermediary, or broker, between a cloud user and the cloud provider.

Defender for Cloud Apps is a Cloud Access Security Broker (CASB). CASBs are cloud-based security solutions that provide a layer of security to enable oversight and control of activities and information across public and custom cloud SaaS apps and IaaS services. CASBs are separated into four key capability areas, including Shadow IT discovery, information protection, threat protection, and compliance. These capability areas represent the framework upon which Defender for Cloud Apps is built.

Defender for Cloud Apps and the Defender for Cloud Apps framework:

- Discover and control the use of Shadow IT. Identify the cloud apps, IaaS, and PaaS services that are used by your organization, some of which might not even be known or controlled by the IT department. Investigate usage patterns and assess the risk levels and business readiness of more than 16,000 SaaS apps against more than 80 risks.
- Help protect your sensitive information anywhere in the cloud. Understand, classify, and help protect the exposure of sensitive information at rest. Leverage out-of-the-box policies and automated processes to apply controls in real time across all your cloud apps.
- Help protect against cyberthreats and anomalies. Detect unusual behavior across cloud apps to identify ransomware, compromised users or rogue applications, analyze high-risk usage, and remediate automatically to limit the risk to your organization.
- Assess the compliance of your cloud apps. Assess if your cloud apps meet relevant compliance requirements, including regulatory compliance and industry standards. Prevent data leaks to non-compliant apps and limit access to regulated data.

Defender for Cloud Apps uniquely integrates with Microsoft Defender for Endpoint (MSDE), a unified endpoint security platform for protection, detection, investigation, and response to enhance the discovery of Shadow IT in your organization.

### Defender for Cloud Apps architecture

Defender for Cloud Apps integrates visibility with your cloud by:

- Using Cloud Discovery to map and identify your cloud environment and the cloud apps your organization is using.
- Sanctioning and unsanctioning apps in your cloud.
- Using easy-to-deploy app connectors that take advantage of provider APIs, for visibility and governance of apps that you connect to.
- Using Conditional Access App Control protection to get real-time visibility and control over access and activities within your cloud apps.
- Helping you have continuous control by setting, and then continually fine-tuning, policies.

:::image type="content" source="../media/6-proxy-architecture.png" alt-text="Image displays Cloud App Security architecture.":::

Cloud Discovery uses your traffic logs to dynamically discover and analyze the cloud apps that your organization is using. To create a snapshot report of your organization's cloud use, you can manually upload log files from your firewalls or proxies for analysis. To set up continuous reports, use Defender for Cloud Apps log collectors to periodically forward your logs. You can use Defender for Cloud Apps to sanction or unsanction apps in your organization by using the Cloud app catalog. The Microsoft team of analysts has an extensive and continuously growing catalog of over 16,000 cloud apps that are ranked and scored based on industry standards. You can use the Cloud app catalog to rate the risk for your cloud apps based on regulatory certifications, industry standards, and best practices. Then, customize the scores and weights of various parameters to your organization's needs. Based on these scores, Defender for Cloud Apps lets you know how risky an app is. Scoring is based on over 80 risk factors that might affect your environment.

## Integration with Azure AD and Azure Information Protection

In the modern workplace, it's essential to enable users to work from any location and any device and grant them access to cloud applications. Increasing collaboration requires data sharing with partners and external collaborators. At the same time, businesses need to safeguard their organization’s data and resources.

Defender for Cloud Apps enables businesses to identify sensitive data across cloud apps, monitor when it's shared with risky environments, and take necessary governance actions by classifying, labeling, and protecting existing and new data in your environment.

Defender for Cloud Apps integrates with Azure AD and Azure Information Protection to deliver these capabilities in a holistic and integrated experience. By empowering businesses with a level of granularity when defining what risk means to their organization, businesses gain control and visibility of any user sessions that match that definition. For example, if an employee tries to access sensitive files from a personal computer on a public network, the system can be set up to block the download altogether or allow the download. With Azure Information Protection, the system can be configured to automatically label and help protect the file in real time. It allows the business to prevent confidential information from leaking outside of the organization.
