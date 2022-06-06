
Microsoft has an enduring commitment to protect data privacy, not as an afterthought, but built into Microsoft Azure from the ground up. Microsoft designed Azure with industry-leading security controls, compliance tools, and privacy policies to safeguard your data in the cloud, including the categories of personal data identified by the GDPR. These also help you comply with other important global and regional privacy standards such as ISO/IEC 27018, EU-U.S. Privacy Shield, EU Model Clauses, HIPAA/HITECH, and HITRUST.

### Leverage Azure Policy

Consider also using Azure Policy to enforce your privacy requirements. Azure Policy is deeply integrated into Azure Resource Manager, which helps your organization to enforce policy across resources. With Azure Policy you can define policies at an organizational level to manage resources and prevent developers from accidentally allocating resources in violation of those policies. You can use Azure Policy in a wide range of compliance scenarios, such as ensuring that your data is encrypted or remains in a specific region to comply with the GDPR.

### Azure's Secure Foundation

When you build on Azure's secure foundation, you accelerate your move to the cloud by achieving compliance more readily, allowing you to enable privacy-sensitive cloud scenarios, such as financial and health service, with confidence. Different organizations will need different levels of privacy requirements based on the industry and compliance standards that are required to follow. Azure provides customers with strong data security, both by default on its own infrastructure, as well as for customer-enabled services.

### State of the Data

When designing your solution to fulfill the privacy requirements, take into consideration the state of the data at a certain point of time. For example, for some scenarios it may not be enough to protect the data only when the data is at rest, you may also need to protect it while in-transit. For example, the PCI DSS requirement 4 is about *Encrypt transmission of cardholder data across open, public networks.* To fulfill this requirement your solution must encrypt data in-transit. Below you have some examples of ta protection according to the data stage:

- **At-rest data protection:** Encryption at rest provides data protection for stored data (at rest). Attacks against data at-rest include attempts to obtain physical access to the hardware on which the data is stored, and then compromise the contained data. In such an attack, a server's hard drive may have been mishandled during maintenance allowing an attacker to remove the hard drive. Later the attacker would put the hard drive into a computer under their control to attempt to access the data. Customers are responsible for ensuring that data stored in Azure is encrypted in accordance with their standards. Azure offers a wide range of encryption capabilities, giving customers the flexibility to choose the solution that best meets their needs. Azure Key Vault helps customers easily maintain control of keys that are used by cloud applications and services to encrypt data. Azure Disk Encryption enables customers to encrypt VMs. Azure Storage Service Encryption makes it possible to encrypt all data placed into a customer's storage account.
- **In-transit data protection:** Protecting data in transit should be an essential part of your data protection strategy. Because data is moving back and forth from many locations, we generally recommend that you always use SSL/TLS protocols to exchange data across different locations. In some circumstances, you might want to isolate the entire communication channel between your on-premises and cloud infrastructures by using a VPN. Microsoft provides a number of options that can be utilized by customers for securing data in transit internally within the Azure network and externally across the Internet to the end user. These include communication through Virtual Private Networks (utilizing IPsec/IKE encryption), Transport Layer Security (TLS) 1.2 or later (via Azure components such as Application Gateway or Azure Front Door), protocols directly on the Azure virtual machines (such as Windows IPsec or SMB), and more.

#### Azure resource providers encryption model support

Microsoft Azure Services each support one or more of the encryptions at rest models. For some services, however, one or more of the encryption models may not be applicable. For services that support customer-managed key scenarios, they may support only a subset of the key types that Azure Key Vault supports for key encryption keys. Additionally, services may release support for these scenarios and key types at different schedules. This section describes the encryption at rest support at the time of this writing for each of the major Azure data storage services.

#### Azure disk encryption

Any customer using Azure Infrastructure as a Service (IaaS) features can achieve encryption at rest for their IaaS VMs and disks through Azure Disk Encryption. For more information on Azure Disk encryption, see the Azure Disk Encryption documentation.

#### Azure storage

All Azure Storage services (Blob storage, Queue storage, Table storage, and Azure Files) support server-side encryption at rest; some services additionally support customer-managed keys and client-side encryption.

#### Azure SQL Database

Azure SQL Database currently supports encryption at rest for Microsoft-managed service side and client-side encryption scenarios. Support for server encryption is currently provided through the SQL feature called Transparent Data Encryption. Once an Azure SQL Database customer enables TDE key are automatically created and managed for them. Encryption at rest can be enabled at the database and server levels. As of June 2017, Transparent Data Encryption (TDE) is enabled by default onnewly created databases. Azure SQL Database supports RSA 2048-bit customer-managed keys in Azure Key Vault. For more information, see Transparent Data Encryption with Bring Your Own Key support for Azure SQL Database and Data Warehouse.

Client-side encryption of Azure SQL Database data is supported through the Always Encrypted feature. Always Encrypted uses a key that is created and stored by the client. Customers can store the master key in a Windows certificate store, Azure Key Vault, or a local Hardware Security Module. Using SQL Server Management Studio, SQL users choose what key they'd like to use to encrypt which column.

#### Data classification

The security controls that will be applied to the data will vary also according to the level of privacy required by the data and to ensure that you're prioritizing the data that it is important to be secure you'll need to classify your data. Data classification is a way of categorizing data assets by assigning unique logical labels or classes to the data assets. Classification is based on the business context of the data. For example, you might classify assets by Passport Number, Driver's License Number, Credit Card Number, SWIFT Code, Person's Name, and so on.

One solution for data classification in Azure is Microsoft Purview. Microsoft Purview is a unified data governance service that helps you manage and govern your on-premises, multi-cloud, and Software as a Service (SaaS) data. Create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage. Enable data curators to manage and secure your data estate. Empower data consumers to find valuable, trustworthy data.

![Microsoft Purview](../media/microsoft-purview.png)

#### Identity Protection

One important aspect of privacy is to ensure that you have a system to protect the user's identity. A compromised identity could lead to data compromise and directly affect the privacy requirements for your project. Consider using Azure AD Identity Protection to enhance your identity protection strategy to ensure you're fulfilling the privacy requirements.

Identity Protection uses the learnings Microsoft has acquired from their position in organizations with Azure AD, the consumer space with Microsoft Accounts, and in gaming with Xbox to protect your users. Microsoft analyzes 6.5 trillion signals per day to identify and protect customers from threats. The signals generated by and fed to Identity Protection, can be further fed into tools like Conditional Access to make access decisions, or fed back to a security information and event management (SIEM) tool for further investigation based on your organization's enforced policies.