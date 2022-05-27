### Identify integration points in an architecture

The Microsoft Cybersecurity Reference Architectures (MCRA) describe
Microsoft\'s cybersecurity capabilities. The reference architectures
describe how Microsoft security capabilities integrate with Microsoft
services and applications, Microsoft cloud platforms such as Azure and
Microsoft 365 third party apps such as ServiceNow and Salesforce, and
third party platforms such as Amazon Web Services (AWS) and Google Cloud
Platform (GCP).

The reference architectures are primarily composed of detailed technical
diagrams on Microsoft cybersecurity capabilities, zero trust user
access, security operations, operational technology (OT), multi-cloud
and cross-platform capabilities, attack chain coverage, azure native
security controls, and security organizational functions.

![Microsoft Cybersecurity Reference Architectures (MCRA)](../media/MCRA.png) 

The MCRA also includes an overview of Zero Trust and a Zero Trust rapid
modernization plan (RaMP). Additionally, this includes other key
information on security operations and key initiatives like protecting
from human operated ransomware, securing privileged access, moving
beyond VPN, and more.

![Zero Trust and related topics](../media/ZeroTrustandRelatedTopics.png)

### Using the MCRA

MCRA is used for several purposes, including: 

-   Starting template for a security architecture: 
The most common use case is to help organizations define a target state for cybersecurity capabilities. Organizations find this architecture useful because it covers capabilities across the modern enterprise estate that now spans on-premise, mobile devices, multiple clouds, and IoT / Operational Technology. 

-   Comparison reference of security capabilities: Some organizations use MCRA to compare Microsoft's architecture recommendations with what they already own and have implemented. Many organizations find that they weren't aware that they already own quite a bit of security architecture technology. 

-   Learn about Microsoft's integration investments: MCRA helps architects and technical teams identify how to take advantage of integration points within Microsoft capabilities and existing security capabilities. 

-   Learn about cybersecurity: Some architects, particularly those new to cybersecurity, use this as a learning tool to prepare for their first career or a career change. 

The primary Cybersecurity Reference Architecture diagram represents the full organizational security landscape, demonstrating how key Microsoft technologies fit into that landscape. 


![The primary Cybersecurity Reference Architecture diagram represents the full organizational security landscape, demonstrating how key Microsoft technologies fit into that landscape.](../media/CybersecurityReferenceArchitecture.png) 

The table below reproduces the information from the diagram showing each
domain, the Microsoft products within it, a summary of the capability
and some additional details.
| Domain | Product | Capability | Details |
|:---:|:---:|:---:|:---:| 
| Identity and Access | | | |
|                     | Azure Active Directory | Cloud-based Identity, Access Management Service | Passwordless & MFA, Hello for Business, Authenticator App, RDO2 Keys, Azure AD PIM, B2B & B2C |
|                                | Identity Protection | Leaked Credential Protection | Behavioral Analytics |
|                                | Identity Governance             | Identity, Access, and Privileged Access Lifecycle, Enttilement Management, Access Reuests, Workflow, Policy and Role Management, Governance Enforcment | Azure AD User Provisioning, Azure AD PIM, Azure AD Reports, and Enterprise Mobility+Security                                                                      |
|                                | Defender for Identity           | User Behavior and Activities, Investigate Alerts, AD FS Protection, Lateral Movement Detection                                                         | AD, Azure AD, SecOps, ADFS,                                                                                                                                       |
| Security Operations            |                                 |                                                                                                                                                        |                                                                                                                                                                   |
|                                | Microsoft Defender              | Extended Detection and Response (XDR)                                                                                                                  | Cloud, Endpoint, Office 365, Identity, SaaS                                                                                                                       |
|                                | Microsoft Sentinel              | Cloud Native SIEM, SOAR, and UEBA for IT, OT and IoT                                                                                                   | Same as Defender + other Tools, logs and data sources                                                                                                             |
|                                |                                 |                                                                                                                                                        |                                                                                                                                                                   |
| Endpoint and Device Security   |                                 |                                                                                                                                                        |                                                                                                                                                                   |
|                                | Microsoft Endpoint Manager      | Unified Endpoint Management                                                                                                                            | Intune and Configuration Manager                                                                                                                                  |
|                                | Microsoft Defender for Endpoint | Unified Endpoint Security                                                                                                                              | Endpoint Detection and Response (EDR), Web Content Filtering, Threat and Vuln management, Endpoint Data Loss protection (DLP)                                     |
| Hybrid Infrastructure          |                                 |                                                                                                                                                        |                                                                                                                                                                   |
|                                | Defender for Cloud              | Security Posture Management, Threat Protection                                                                                                         | Cross Platform, Cross Cloud XDR                                                                                                                                   |
|                                | Azure AD App Proxy              | Secure Remote Access                                                                                                                                   | Azure AD, Web Applications, SSO                                                                                                                                   |
|                                | Azure Arc                       | Hybrid and Multicloud Management                                                                                                                       | Azure Security, Cloud-Native Services, Windows, Linux, SQL Server, Kubernetes                                                                                     |
|                                | Azure Stack                     | Hybrid and Edge Computing                                                                                                                              | Edge, IoT, Network, Machine Learning, Datacenter                                                                                                                  |
|                                | Azure Firewall                  | Intelligent Network Firewall                                                                                                                           | Azure, Networking Services, Security, TLS Inspection, IDPS, URL Filtering, Web Categories                                                                         |
|                                | Azure WAF                       | Intelligent Application Firewall                                                                                                                       | Azure AD, Web Applications                                                                                                                                        |
|                                | DDoS Protection                 | DDoS Mitigation                                                                                                                                        | Azure, Networking Services, Virtual Networks                                                                                                                      |
|                                | Azure Key Vault                 | Encryption, Authentication, Secrets Management,                                                                                                        | Azure, Azure AD, Enterprise Application                                                                                                                           |
|                                | Azure Baston                    | Separate Administration Workstation                                                                                                                    | PaaS, Secure RDP/SSH, Secure VM                                                                                                                                   |
|                                | Azure Lighthouse                | Azure Delegated Resource Management, Azure Resources Templates, Managed Service                                                                        | Cross-Tenant Management, Azure Identity, Azure Resource Manager                                                                                                   |
|                                | Azure Backup                    | On-Premises and Cloud Backup Solution                                                                                                                  | On-Premises, Azure VMs, Azure Managed Disks, Azure Files Shares, SQL Server in Azure VMs, SAP Hanna Databases, Azure Database for PostgreSQL Servers, Azure Blobs |
|                                | Express Route                   | On-Premises Network Extension                                                                                                                          | Layer 3 Connectvity, Connectivity to Microsoft Cloud Services, Global Connectivity to Microsoft Services, Dynamic Routing, Built-In Redundancy                    |
|                                | Private Link                    | Private Azure Access, On-Premises and Peered Networks, Data Leakage Protection                                                                         | PaaS, Storage, SQL Databases, Network                                                                                                                             |
| Information Protection         |                                 |                                                                                                                                                        |                                                                                                                                                                   |
|                                | Azure Purview                   | Unified Data Governance, Automated Data Discovery, Senstive Data Classificatoin                                                                        | Microsoft Information Protection (MIP), File Scanner, Data Governance, Advanced eDiscovery                                                                        |
|                                | Compliance Manager              | Pre-Built Assessments, Workflow, Risk-Based Compliance Score                                                                                           | Azure Controls, Assessments, Templates, Improvement Actions                                                                                                       |
| People Security                |                                 |                                                                                                                                                        |                                                                                                                                                                   |
|                                | Attack Simulator                | Simulation Training Platform                                                                                                                           | Credential Harvest, Malware Attachment, Link in Attachment, LInk to Malware, Drive-by-URL                                                                         |
|                                | Insider Risk Management         | Compliance Solution, Data Leak, Workflow                                                                                                               | Policies, Alerts, Triage, Investigation, Action                                                                                                                   |
|                                | Communication Compliance        | Insider Risk Solution, Flexible Remediation Workflows, Actionable Insights, Customizable Templates                                                     | Corporate Policies, Risk Management, Regulatory Compliance                                                                                                        |
| IoT and Operational Technology |                                 |                                                                                                                                                        |                                                                                                                                                                   |
|                                | Azure Sphere                    | IoT and OT Security Services                                                                                                                           | Microcontroller Unit (MCU, Networking Services, Patch Management,                                                                                                 |
|                                | Defender for Cloud              | Security Posture Management, Threat Protection                                                                                                         | Cross Platform, Cross Cloud XDR                                                                                                                                   |
|                                | Defender for IoT                | Asset Discovery, Vulneability Management, Network Detection and Response (NDR)                                                                         | IoT, SCADA, OT, Threat Detection & Response, Asset & Vulnerability Management                                                                                     |
