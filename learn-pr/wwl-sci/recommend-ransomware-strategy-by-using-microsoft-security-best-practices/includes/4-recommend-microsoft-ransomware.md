
**Phase 3** of ransomware protection is to make it hard to get in.

In this phase, you make the attackers work a lot harder to get into your on-premises or cloud infrastructures by incrementally removing the risks at the points of entry.

The general best practices for hardening your infrastructure against ransomware attacks are divided into four main areas:

- [Remote access](#remote-access)
- [Email and collaboration](#email-and-collaboration)
- [Endpoints](#endpoints)
- [Accounts](#accounts)

### Remote access

Gaining access to your organization's intranet through a remote access connection is an attack vector for ransomware attackers. Once an on-premises user account is compromised, an attacker is free to roam on an intranet to gather intelligence, elevate privileges, and install ransomware. The Colonial Pipeline cyberattack in 2021 is an example.

#### Program and project member accountabilities

This table describes the overall protection of your remote access solution from ransomware in terms of a sponsorship/program management/project management hierarchy to determine and drive results.

| Lead | Implementor | Accountability |
|:-------|:-------|:-----|
| CISO or CIO | | Executive sponsorship |
| Program lead on the [Central IT](/azure/cloud-adoption-framework/organize/central-it) Infrastructure/Network Team | | Drive results and cross-team collaboration |
| | IT and [Security](/azure/cloud-adoption-framework/organize/cloud-security-architecture) Architects | Prioritize component integration into architectures |
|  | [Central IT](/azure/cloud-adoption-framework/organize/central-it) Identity Team | Configure Azure AD and conditional access policies |
|  | [Central IT](/azure/cloud-adoption-framework/organize/central-it) Operations | Implement changes to environment |
|  | Workload Owners | Assist with RBAC permissions for app publishing |
| | [Security Policy and Standards](/azure/cloud-adoption-framework/organize/cloud-security-policy-standards) | Update standards and policy documents |
| | [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management) | Monitor to ensure compliance |
| | User Education Team | Update any guidance on workflow changes and perform education and change management |
||||

#### Implementation checklist

Apply these best practices to protect your remote access infrastructure from ransomware attackers.

| Done| Task | Description |
|:-------|:-------|:-----|
| <input type="checkbox" /> | Maintain software and appliance updates. Avoid missing or neglecting manufacturer protections (security updates, supported status). | Attackers use well-known vulnerabilities that have not yet been patched as attack vectors. |
| <input type="checkbox" /> | Configure Azure Active Directory (Azure AD) for existing remote access by including enforcing [Zero Trust](https://www.microsoft.com/security/business/zero-trust) user and device validation with Conditional Access. | Zero Trust provides multiple levels of securing access to your organization. |
| <input type="checkbox" /> | Configure security for existing third-party VPN solutions (Cisco [AnyConnect](/azure/active-directory/saas-apps/cisco-anyconnect), Palo Alto Networks [GlobalProtect](/azure/active-directory/saas-apps/palo-alto-networks-globalprotect-tutorial) & [Captive Portal](/azure/active-directory/saas-apps/paloaltonetworks-captiveportal-tutorial), Fortinet [FortiGate SSL VPN](/azure/active-directory/saas-apps/fortigate-ssl-vpn-tutorial), Citrix [NetScaler](/azure/active-directory/saas-apps/citrix-netscaler-tutorial), [Zscaler Private Access (ZPA)](/azure/active-directory/saas-apps/zscalerprivateaccess-tutorial), and [more](/azure/active-directory/saas-apps/tutorial-list)). | Take advantage of the built-in security of your remote access solution. |
| <input type="checkbox" /> | Deploy [Azure Point-to-Site (P2S) VPN](/azure/vpn-gateway/openvpn-azure-ad-tenant#enable-authentication) to provide remote access. | Take advantage of integration with Azure AD and your existing Azure subscriptions. |
| <input type="checkbox" /> | Publish on-premises web apps with [Azure AD Application Proxy](/azure/active-directory/manage-apps/application-proxy-integrate-with-remote-desktop-services). | Apps published with Azure AD Application Proxy do not need a remote access connection. |
| <input type="checkbox" /> | Secure access to Azure resources with [Azure Bastion](/azure/bastion/bastion-overview). | Securely and seamlessly connect to your Azure virtual machines over SSL. |
| <input type="checkbox" /> | Audit and monitor to find and fix deviations from baseline and potential attacks (see [Detection and Response](/azure/security/fundamentals/protect-against-ransomware-phase2.md#detection-and-response)).  |  Reduce risk from ransomware activities that probe baseline security features and settings. |
|  |  |  |


### Email and collaboration

Implement best practices for email and collaboration solutions to make it more difficult for attackers to abuse them, while allowing your workers to access external content easily and safely.

Attackers frequently enter the environment by transferring malicious content in with authorized collaboration tools such as email and file sharing and convincing users to run it. Microsoft has invested in enhanced mitigations that vastly increase protection against these attack vectors. 

#### Program and project member accountabilities

This table describes the overall protection of your email and collaboration solutions from ransomware in terms of a sponsorship/program management/project management hierarchy to determine and drive results.

| Lead | Implementor | Accountability |
|:-------|:-------|:-----|
| CISO, CIO, or Identity Director | | Executive sponsorship |
| Program lead from the [Security Architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture) team| | Drive results and cross-team collaboration |
| | IT Architects | Prioritize component integration into architectures |
|  | Cloud Productivity or End User Team  | Enable Defender for Office 365, ASR, and AMSI |
|  | [Security Architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture) / [Infrastructure + Endpoint](/azure/cloud-adoption-framework/organize/cloud-security-infrastructure-endpoint)  | Configuration assistance |
| | User Education Team | Update guidance on workflow changes |
| | [Security Policy and Standards](/azure/cloud-adoption-framework/organize/cloud-security-policy-standards) | Update standards and policy documents |
| | [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management) | Monitor to ensure compliance |
||||

#### Implementation checklist

Apply these best practices to protect your email and collaboration solutions from ransomware attackers.

| Done| Task | Description |
|:-------|:-------|:-----|
| <input type="checkbox" /> | Enable [AMSI for Office VBA](https://www.microsoft.com/security/blog/2018/09/12/office-vba-amsi-parting-the-veil-on-malicious-macros/). | Detect Office macro attacks with endpoint tools like [Defender for Endpoint](/windows/security/threat-protection/microsoft-defender-atp/microsoft-defender-advanced-threat-protection).|
| <input type="checkbox" /> | Implement Advanced Email security using [Defender for Office 365](/microsoft-365/security/office-365-security/office-365-atp) or a similar solution. | Email is a common entry point for attackers. |
| <input type="checkbox" /> | [Deploy attack surface reduction (ASR) rules](/microsoft-365/security/defender-endpoint/attack-surface-reduction-rules-deployment) to block common attack techniques including: <br><br> - Endpoint abuse such as credential theft, ransomware activity, and suspicious use of PsExec and WMI. <br><br> - Weaponized Office document activity such as advanced macro activity, executable content, process creation, and process injection initiated by Office applications. <br><br> **Note:** Deploy these rules in audit mode first, then assess any negative impact, and then deploy them in block mode. | ASR provides additional layers of protect specifically targeted at mitigating common attack methods. |
| <input type="checkbox" /> | Audit and monitor to find and fix deviations from baseline and potential attacks (see [Detection and Response](/azure/security/fundamentals/protect-against-ransomware-phase2.md#detection-and-response)). |  Reduces risk from ransomware activities that probe baseline security features and settings. |
|  |  |  |


### Endpoints

Implement relevant security features and rigorously follow software maintenance best practices for endpoints (devices) and applications, prioritizing applications and server/client operating systems directly exposed to Internet traffic and content.

Internet-exposed endpoints are a common entry vector that provides attackers access to the organization's assets. Prioritize blocking common OS and application vulnerabilities with preventive controls to slow or stop them from executing the next stages. 

#### Program and project member accountabilities

This table describes the overall protection of your endpoints from ransomware in terms of a sponsorship/program management/project management hierarchy to determine and drive results.

| Lead | Implementor | Accountability |
|:-------|:-------|:-----|
| Business leadership accountable for business impact of both downtime and attack damage | | Executive sponsorship (maintenance) |
| [Central IT](/azure/cloud-adoption-framework/organize/central-it) Operations or CIO | | Executive sponsorship (others) |
| Program lead from the [Central IT](/azure/cloud-adoption-framework/organize/central-it) Infrastructure Team| | Drive results and cross-team collaboration |
| | IT and [Security](/azure/cloud-adoption-framework/organize/cloud-security-architecture) Architects | Prioritize component integration into architectures |
|  | [Central IT](/azure/cloud-adoption-framework/organize/central-it) Operations | Implement changes to environment |
|  | Cloud Productivity or End User Team  | Enable attack surface reduction |
|  | Workload/App Owners | Identify maintenance windows for changes |
| | [Security Policy and Standards](/azure/cloud-adoption-framework/organize/cloud-security-policy-standards) | Update standards and policy documents |
| | [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management) | Monitor to ensure compliance |
||||

#### Implementation checklist

Apply these best practices to all Windows, Linux, MacOS, Android, iOS, and other endpoints.

| Done| Task | Description |
|:-------|:-------|:-----|
| <input type="checkbox" /> | Block known threats with [attack surface reduction](/microsoft-365/security/defender-endpoint/attack-surface-reduction-rules-deployment) rules, [tamper protection](/microsoft-365/security/defender-endpoint/prevent-changes-to-security-settings-with-tamper-protection), and [block at first site](/windows/security/threat-protection/microsoft-defender-antivirus/configure-block-at-first-sight-microsoft-defender-antivirus). | Don't let lack of use of these built-in security features be the reason an attacker entered your organization. |
| <input type="checkbox" /> | Apply [Security Baselines](https://techcommunity.microsoft.com/t5/microsoft-security-baselines/bg-p/Microsoft-Security-Baselines) to harden internet-facing Windows servers and clients and Office applications. | Protect your organization with the minimum level of security and build from there. |
| <input type="checkbox" /> | Maintain your software so that it is: <br><br> - Updated: Rapidly deploy critical security updates for operating systems, browsers, & email clients <br><br> - Supported:  Upgrade operating systems and software for versions supported by your vendors. | Attackers are counting on you missing or neglecting manufacturer updates and upgrades. |
| <input type="checkbox" /> | Isolate, disable, or retire insecure systems and protocols, including [unsupported operating systems](/lifecycle/) and [legacy protocols](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/retire-those-old-legacy-protocols/ba-p/259396). | Attackers use known vulnerabilities of legacy devices, systems, and protocols as entry points into your organization. |
| <input type="checkbox" /> | Block unexpected traffic with host-based firewall and network defenses. | Some malware attacks rely on unsolicited inbound traffic to hosts as a way of making a connection for an attack. |
| <input type="checkbox" /> | Audit and monitor to find and fix deviations from baseline and potential attacks (see [Detection and Response](/azure/security/fundamentals/ransomware-protection)). | Reduces risk from ransomware activities that probe baseline security features and settings. |
|  |  |  |

### Accounts

Just as antique skeleton keys won’t protect a house against a modern-day burglar, passwords cannot protect accounts against common attacks we see today. While multi-factor authentication (MFA) was once a burdensome extra step, passwordless authentication improves the sign-in experience using biometric approaches that don’t require your users to remember or type a password. Additionally, a [Zero Trust](https://www.microsoft.com/security/business/zero-trust) infrastructure stores information about trusted devices, which reduce prompting for annoying out-of-band MFA actions.

Starting with high-privilege administrator accounts, rigorously follow these best practices for account security including using passwordless or MFA.

#### Program and project member accountabilities

This table describes the overall protection of your accounts from ransomware in terms of a sponsorship/program management/project management hierarchy to determine and drive results.

| Lead | Implementor | Accountability |
|:-------|:-------|:-----|
| CISO, CIO, or Identity Director | | Executive sponsorship |
| Program lead from [Identity and Key Management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys) or [Security Architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture) teams | | Drive results and cross-team collaboration |
| | IT and [Security](/azure/cloud-adoption-framework/organize/cloud-security-architecture) Architects | Prioritize component integration into architectures |
| | [Identity and Key Management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys) or [Central IT](/azure/cloud-adoption-framework/organize/central-it) Operations | Implement configuration changes |
| | [Security Policy and Standards](/azure/cloud-adoption-framework/organize/cloud-security-policy-standards) | Update standards and policy documents |
| | [Security Compliance Management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management) | Monitor to ensure compliance |
| | User Education Team | Update password or sign-in guidance and perform education and change management |
||||

#### Implementation checklist

Apply these best practices to protect your accounts from ransomware attackers.

| Done| Task | Description |
|:-------|:-------|:-----|
| <input type="checkbox" /> | Enforce strong MFA or passwordless sign-in for all users. Start with administrator and [priority](/microsoft-365/admin/setup/priority-accounts) accounts using one or more of: <br><br> - Passwordless authentication with [Windows Hello](/windows/security/identity-protection/hello-for-business/hello-identity-verification) or the [Microsoft Authenticator app](/azure/active-directory/authentication/howto-authentication-phone-sign-in). <br><br> - [Azure Multi-Factor Authentication](/azure/active-directory/authentication/howto-mfa-userstates). <br><br> - A third-party MFA solution. | Make it harder for an attacker to perform a credential compromise by just determining a user account password. |
| <input type="checkbox" /> | Increase password security: <br><br> - For Azure AD accounts, use [Azure AD Password Protection](/azure/active-directory/authentication/concept-password-ban-bad) to detect and block known weak passwords and additional weak terms that are specific to your organization. <br><br> - For on-premises Active Directory Domain Services (AD DS) accounts, [Extend Azure AD Password Protection](/azure/active-directory/authentication/concept-password-ban-bad-on-premises) to AD DS accounts. | Ensure that attackers can't determine common passwords or passwords based on your organization name. |
| <input type="checkbox" /> | Audit and monitor to find and fix deviations from baseline and potential attacks (see [Detection and Response](/azure/security/fundamentals/ransomware-protection)). | Reduces risk from ransomware activities that probe baseline security features and settings. |
|  |  |  |

#### Implementation results and timelines

Try to achieve these results within 30 days:

- 100 % of employees are actively using MFA
- 100 % deployment of higher password security
