Wide World Importers' has thousands of machines across multiple offices. Given the scale of the deployment, an immediate concern is how to successfully onboard all the servers.   
For a single server, onboarding options include Azure portal, Azure PowerShell, Azure PowerShell DSC, and Windows Admin Center. For multiple servers, onboarding options include Azure service principal and Azure Automation Update Management. Furthermore, the Service Principal approach can be automated using a configuration management tool of choice (ex. Group Policy, Systems Center Configuration Manager, Ansible, etc.). 

With many deployment methods, you can deploy Azure Arc-enabled servers at scale using the tooling that best fits the needs and expertise of your organization. 

## Deploy to a single server

There are a range of options to arc-enable a single server including Azure portal, PowerShell, PowerShell DSC, and Windows Admin Center.

| Method | Description |
|---|---|
| **Azure portal** | After submitting resource and deployment details in Azure portal, you're provided with a script to Arc-enable a server. You must download and run this script with elevated privileges in your Windows or Linux servers. This requires that you authenticate to your Azure subscription interactively for each installation. |
| **PowerShell** | You can use the PowerShell cmdlet Connect-AzConnectedMachine to download the Connected Machine agent, install the agent, and register the machine with Azure Arc. The cmdlet downloads the Windows agent package (Windows Installer) from the Microsoft Download Center, and the Linux agent package from the Microsoft package repository. |
| **PowerShell DSC** | Using Windows PowerShell Desired State Configuration (DSC), you can automate software installation and configuration for a Windows computer. You can install the ConnectedMachine DSC module, which is designed to manage the Azure Connected Machine Agent configuration. The module also contains a PowerShell script AzureConnectedMachineAgent.ps1, to automate the download and installation, and establish a connection with Azure Arc. This resource can be added to existing DSC configurations to represent an end-to-end configuration for a machine. |
| **Windows Admin Center** | You can use Windows Admin Center to deploy the Connected Machine agent and register your on-premises servers without having to do any steps outside of this tool. Select the "Leverage Azure policies and solutions to manage your servers with Azure Arc" service under Azure hybrid services in the Windows Admin Center. |

## Deploy to multiple servers

For at scale deployment of Arc-enabled servers, a privileged identity with Service Principal can be used. This script can be coupled with myriad configuration management tools to automate onboarding for multiple servers. Instead, non-Azure machines already managed by Update Management can be directly onboarded from Azure portal. 

| Method | Description |
|---|---|
| **Connect Multiple Machines with Service Principal** | To securely connect machines to Azure Arc at scale, you can use an Azure Active Directory service principal instead of using your privileged identity to interactively connect the machine. A service principal is a special limited management identity that is granted only the minimum permission necessary to connect machines to Azure using the azcmagent command. This approach is safer than using a higher privileged and follows our access control security best practices. The service principal is used only during onboarding, it isn't used for any other purpose. |
| **Update Management (Azure portal)** | Non-Azure servers managed by the Update Management service can be easily connected to Azure via Azure Arc. You can select these non-Azure servers directly in Azure portal, and the deployment will happen automatically. |

A range of existing software configuration products can be used to deploy the Arc-enabled server agent to machines at scale. The script for deployment should rely on the Azure Service Principal method because the Single Server script for deployment requires separate authentication for each server. 

- Group Policy: Define a new Group Policy Object for running a PowerShell script, assign the GPO to the desired Organization Unit, and schedule a task to deploy to multiple servers. 

- Systems Center Configuration Manager: Author, approve, and run a custom PowerShell script to a collection of devices. See [Create and run scripts - Configuration Manager](/mem/configmgr/apps/deploy-use/create-deploy-scripts).

- Other automation tooling like Chef, Puppet, or Ansible can also be used to deploy the script to managed servers.

Additional Resources for at-scale onboarding include:

- [At-scale onboarding VMware vSphere Windows Server VMs](https://github.com/microsoft/azure_arc/blob/main/docs/azure_arc_jumpstart/azure_arc_servers/scaled_deployment/vmware_scaled_powercli_win/_index.md)
- [At-scale onboarding VMware vSphere Linux VMs](https://github.com/microsoft/azure_arc/blob/main/docs/azure_arc_jumpstart/azure_arc_servers/scaled_deployment/vmware_scaled_powercli_linux/_index.md)
- [At-scale onboarding AWS EC2 instances using Ansible](https://github.com/microsoft/azure_arc/blob/main/docs/azure_arc_jumpstart/azure_arc_servers/scaled_deployment/aws_scaled_ansible/_index.md)
