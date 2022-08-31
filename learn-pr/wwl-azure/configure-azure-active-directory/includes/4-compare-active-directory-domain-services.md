Active Directory Domain Service (Azure AD DS) is the traditional deployment of Windows Server-based Active Directory on a physical or virtual server. Azure AD DS is commonly considered to be primarily a directory service, but it's only one component of the Windows Active Directory suite of technologies. The suite also includes Active Directory Certificate Services (AD CS), Active Directory Lightweight Directory Services (AD LS), Active Directory Federation Services (AD FS), and Active Directory Rights Management Services (AD RMS).

> [!Important]
> You can deploy and manage Azure AD DS in Azure Virtual Machines, but unless you're targeting IaaS workloads that depend on Azure AD DS specifically, we recommend you use Azure AD.

### Things to consider when using Azure AD rather than Azure AD DS

Azure AD is similar to Azure AD DS, but there are some significant differences. It's important to understand that using Azure AD is different from deploying an Active Directory domain controller on an Azure virtual machine and then adding it to your on-premises domain.

As you plan your identity strategy, consider the following characteristics that distinguish Azure AD from Azure AD DS.

- **Identity solution**: Azure AD DS is primarily a directory service, while Azure AD is a full identity solution. Azure AD is designed for internet-based applications that use HTTP and HTTPS communications. The features and capabilities of Azure AD support target strong identity management.

- **REST API queries**: Azure AD is based on HTTP and HTTPS protocols. Azure AD tenants can't be queried by using LDAP. Azure AD uses the REST API over HTTP and HTTPS.

- **Communication protocols**: Because Azure AD is based on HTTP and HTTPS, it doesn't use Kerberos authentication. Azure AD implements HTTP and HTTPS protocols, such as SAML, WS-Federation, and OpenID Connect for authentication (and OAuth for authorization).

- **Federation services**: Azure AD includes federation services, and many third-party services like Facebook.

- **Flat structure**: Azure AD users and groups are created in a flat structure. There are no organizational units (OUs) or group policy objects (GPOs).

- **Managed service**: Azure AD is a managed service. You manage only users, groups, and policies. If you deploy Azure AD DS with virtual machines by using Azure, you manage many other tasks, including deployment, configuration, virtual machines, patching, and other backend processes.