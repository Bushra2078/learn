Azure Arc lets you manage physical and virtual Linux machines hosted outside of Azure, on your corporate network, or other cloud provider. Organizations like Contoso can manage their Linux resources with Azure just as they do their Arc-enabled Windows machines. Linux machines onboarded to Azure Arc enjoy the same capabilties as native Azure machines, including standard Azure constructs such as Azure policy and applying tags.

Once your Linux machines are onboarded to Azure Arc, you can:

- Proactively monitor the OS and workloads running on the machine
- Manage the machines using automation runbooks or solutions like Update Management
- Use other Azure services such as Microsoft Defender for Cloud

## Supported Linux distributions

The following Linux distributions are officially supported for the Azure Connected Machine agent:

- Ubuntu 16.04, 18.04, 20.04, and 22.04 LTS
- Debian 10 and 11
- CentOS Linux 7 and 8
- Rocky Linux 8
- SUSE Linux Enterprise Server (SLES) 12 and 15
- Red Hat Enterprise Linux (RHEL) 7 and 8
- Amazon Linux 2
- Oracle Linux 7 and 8

## Azure Automation

Linux machines onboarded to Azure Arc can use Azure Automation for frequent, time-consuming tasks.

### Change tracking and inventory

You can track changes in your Azure Arc Linux machines to help you pinpoint operational and environmental issues. Items that are tracked by the Change Tracking and Inventory feature include:

- Linux software (packages)
- Linux files
- Linux daemons

### Update Management

Your onboarded Linux machines can use Update Management to manage operating system updates. You can quickly assess the status of available updates and manage the process of installing required updates for your Linux machines. Update Management integrates with Azure Monitor Logs to store update assessments and update deployment results as log data.

## Security

Arc-enabled Linux machines enjoy the same security features as all Azure resources, including Microsoft Defender for Cloud and Azure Monitor agent.

### Microsoft Defender for Cloud

Microsoft Defender for Cloud is a Cloud Security Posture Management (CSPM) and Cloud Workload Protection Platform (CWPP). Defender for cloud can monitor the security posture of your Arc-enabled Linux machines and fills three vital needs as you manage the security of your Linux resources and workloads:

- Continuous assessment of your security posture so you can track new security opportunities and precisely report on the progress of your security efforts.
- Secures your workloads with step-by-step actions that protect your workloads from known security risks.
- Provides alerts to defend your workloads in real-time so you can react immediately and prevent security events from developing.

### Azure Monitor Agent (AMA)

Azure Monitor Agent (AMA) collects monitoring data from the guest operating system of Azure and hybrid virtual machines and delivers it to Azure Monitor for use by features, insights, and other services, such as Microsoft Defender for Cloud. AMA uses data collection rules that let you define the types of data you want each agent you install to collect. This allows you to create unique, scoped configurations for subsets of your Linux machines. These rules are independent of the workspace and the virtual machine, which means you can define a rule once and reuse it across machines and environments.

