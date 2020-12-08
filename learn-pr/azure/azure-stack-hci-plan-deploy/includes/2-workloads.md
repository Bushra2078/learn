There are still many customers that are not ready to transition to the hybrid operational model and rely on traditional tools and methods to deploy and manage Windows or Linux servers running in on-premises datacenters. There are also some workloads that are better suited for the traditional on-premises operational model or must remain on-premises to satisfy regulatory or compliance requirements. The group of heavily utilized Microsoft SQL Server instances hosting transactional databases for the Contoso's loan origination department or the planned isolated VDI farm for users in Contoso’s investment banking department are examples of such workloads. Azure Stack HCI can help with implementing these types of scenarios optimally.

## What are typical Azure Stack HCI workloads?

Azure Stack HCI allows you to deploy Windows and Linux-based virtualized and containerized workloads on a hyperconverged infrastructure (HCI) cluster in your own datacenter or in a datacenter managed by a service provider. From the hardware standpoint, each Azure Stack HCI cluster consists of between 2 and 16 physical, validated servers running a specialized operating system purposely defined for hyperconverged infrastructure.

> [!NOTE]
> Azure Stack HCI clusters are available as integrated systems from a range of hardware vendors, with configuration validated and certified by Microsoft.

You can use Azure Stack HCI to virtualize classic enterprise apps, such as Microsoft Exchange, Microsoft SharePoint, and Microsoft SQL Server. You also can use it to host VMs running a wide range of Windows Server roles, delivering such services as File Server, Domain Name System (DNS), Dynamic Host Configuration Protocol (DHCP), Internet Information Services (IIS), and Active Directory Domain Services (AD DS).

In addition, Azure Stack HCI provides built-in support for disaster recovery of virtualized workloads through stretched clustering. An Azure Stack HCI stretched cluster offers automatic failover of VMs to a secondary site following a primary site failure. Synchronous replication ensures crash consistency of VM disk files.

## What are Azure Stack HCI technical use cases?

To assist customers with the process of evaluating suitability of their workloads for Azure Stack HCI-based deployments and identifying appropriate hardware configuration, Microsoft established the Azure Stack HCI Technical Use Case program. Through the program, Microsoft certifies Azure Stack HCI hardware configurations in the following use cases:

:::image type="content" source="../media/2-azs-hci-workloads.png" alt-text="The image illustrating the six certified Azure Stack HCI use cases, including branch office and edge, virtual desktop infrastructure, high-performance Microsoft SQL Server, trusted enterprise virtualization, and Azure Kubernetes Service." border="false":::

### Branch office and Edge

Azure Stack HCI provides reasonably priced yet highly available compute, storage, and networking resources for business-critical applications and edge workloads that integrate with containerization and Azure IoT Edge technologies. You can minimize infrastructure cost by deploying two-node clusters that deliver high availability by taking advantage of inexpensive witness options, such as Cloud Witness or a USB drive-based file share witness attached to a network device accessible by both cluster nodes. Another factor that contributes to the lower cost of two-node clusters is support for switchless networking, which relies on cross-over cable between cluster nodes instead of more expensive high-speed switches. This capability distinguishes Azure Stack HCI from equivalent HCI solutions offered by other vendors. Similarly, for less demanding workloads, you can choose single-socket servers with as few as eight cores and storage with solid-state drives (SSDs) in a single tier or hard-disk drives (HDD) in the capacity tier.

### Virtual desktop infrastructure

Azure Stack HCI clusters are well suited for large-scale virtual desktop infrastructure (VDI) deployments, with Microsoft Remote Desktop Services or equivalent third-party offerings serving the role of a virtual desktop broker. Azure Stack HCI provides additional benefits, in this use case, including centralized storage and enhanced security, which simplifies protecting user data and minimizing the risk of accidental or intentional data leaks. Estimating the best cluster size is relatively straightforward because you can base it on the anticipated number of VDI users.

Running Windows VDI workloads on the Windows Server platform provides the benefits of minimizing potential compatibility issues, eliminating the need for multivendor support arrangements, and streamlining administrative tasks. VDI clients have direct access to other Windows-based services, such as file shares, running within the same cluster.

### High-performance Microsoft SQL Server

Azure Stack HCI provides an additional layer of resiliency to highly available, mission-critical, Always On Availability Groups-based deployments of SQL Server. Using Microsoft-certified and Windows Server 2019-based HCI running SQL Server workloads offers extra benefits associated with the single-vendor approach, including simplified support and performance optimizations built into the underlying platform.

> [!NOTE]
> Azure Stack HCI supports both Windows and Linux VMs, allowing you to choose between the Windows and Linux-based SQL Server versions.

### Trusted enterprise virtualization

Azure Stack HCI satisfies the requirements of trusted enterprise virtualization through its built-in support for virtualization-based security (VBS). VBS relies on Hyper-V to implement the mechanism referred to as virtual secure mode, which forms a dedicated, isolated memory region within its guest VMs. By using programming techniques, you can perform designated, security-sensitive operations in this dedicated memory region while maintaining a layer of obfuscation from the host operating system. This considerably limits potential vulnerability to kernel-based exploits.

VBS allows you to implement Hypervisor-Enforced Code Integrity (HVCI) and Credential Guard, which significantly strengthens the security stance of Azure Stack HCI-based workloads. HVCI code-integrity policy enforcement enhances code integrity, which identifies and remediates any unauthorized changes to device drivers and operating system files. HVCI runs the code-integrity service inside virtual secure mode, effectively protecting it from the operating system-based malware. Credential Guard protects cached sign-in credentials by storing them in virtual secure mode. Note that both features use Trusted Platform Module (TPM) capabilities that are built into the Azure Stack HCI hardware.

> [!NOTE]
> The United States Department of Defense considers both VBS and HVCI to be a general security requirement.

### Azure Kubernetes Service on Azure Stack HCI (AKS-HCI)

You can leverage the Azure Stack HCI to host container-based deployments, increasing workload density and resource usage efficiency. Azure Kubernetes Service on Azure Stack HCI (AKS-HCI) is a Kubernetes-based orchestrator that automates running containerized applications on clusters that use Azure Stack HCI. Orchestrators such as the open-source Kubernetes, automate much of the work involved with deploying and managing multiple containers. However, Kubernetes can be complex to set up and maintain. AKS-HCI helps simplify setting up Kubernetes on-premises, making it quicker to get started hosting Linux and Windows containers. By bringing the power of AKS from Azure to your on-premises locations, you benefit from the advanced security, management and deployment experiences for running your workloads, all while reducing the complexity and learning curve for your users.

AKS-HCI is ideal for customers who want to run containerized workloads within their on-premises environments, whether that be at an edge remote site, or in the datacenter, to meet network or regulatory goals. With an existing Azure Stack HCI cluster in place, and after validating several prerequisites, Windows Admin Center guides administrators through first configuring an AKS management cluster. This is responsible for provisioning and managing target clusters where your workloads run, and includes an API server and a Load Balancer. 
