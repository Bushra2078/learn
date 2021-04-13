Azure Security Center ensures that you are making the security configuration of your resources as secure as possible. Because your company is a financial organization, it needs to meet the highest standards for security. Each transaction that a customer or partner starts must be entirely protected from threats. Your company must also respond effectively to each potential threat. For example, if a virtual machine is compromised, you must act rapidly and address the issue.

You'll provide information about how to protect resources, and respond to threats by using Azure Security Center.

## Criteria for assessing Azure Security Center

You use Security Center to:

- Understand the security posture of your architecture.
- Identify and address risks and threats to your infrastructure.
- Need the traditional in-house skills and capital to secure a complex infrastructure.
- Secure an infrastructure that consists of on-premises and cloud resources.

## Understand the security posture of your architecture

Security Center gives detailed analyses of different components of your environment. These components include data security, network security, identity and access, and application security. This way, Security Center helps you understand the security of your architecture. You can then build and maintain better infrastructures. Security Center collects data from your machines to monitor for security vulnerabilities and threats using Azure Monitor Logs. Data is collected using the Log Analytics agent, which reads various security-related configurations and event logs from the machine, and copies the data to your Log Analytics workspace for analysis.

![Screenshot of Azure Security Center Overview.](../media/6-security-center-update-01.png)

Security Center recommends how to address the issues and risks that it has uncovered. You use recommendations like the following one to improve the security and compliance of your architecture.

![Screenshot of recommendation in Azure Security Center.](../media/6-security-center-update-02.png)

## Protect against threats with Azure Security Center

Use access and application controls in Security Center to help protect your resources. These controls block suspicious activity. For example, you protect your virtual machines through just-in-time (JIT) virtual machine access. JIT is a feature that blocks persistent access to virtual machines. Your virtual machines are only accessed based on audited access that you configure.

You enable JIT through the **Just in time VM access** option in the **Azure Defender, Advanced protection** section of Security Center in the Azure portal. You'll see all virtual machines that already have JIT configured, and a list of virtual machines where JIT is not configured. Choose a virtual machine in the not configured list, and then select the **Enable JIT on (number) VM** option to configure JIT for the virtual machine.

Security Center shows you a list of default ports that JIT will target. You can also configure your own, as shown in the following example.

![Screenshot of JIT configuration.](../media/6-security-center-update-03.png)

You can control which applications are allowed to run on your virtual machines through adaptive application controls. In the background, Security Center uses machine learning to look at the processes running on your virtual machine. It creates exception rules for each resource group that holds your virtual machines, and it gives recommendations.

You can configure adaptive controls by selecting the **Adaptive application controls** option in the **Azure Defender, Advanced protection** section of the Azure Security Center menu. You'll see resource groups that contain your virtual machines. See the **Recommended** section to view the list of resource groups that Security Center recommends for adaptive application controls.

![Screenshot of Adaptive application controls.](../media/6-security-center-update-04.png)

When you select a resource group, you use **Create application control rules** to target the virtual machines. You also use it to target the processes, which should have the rule applied.

## Respond to threats with Azure Security Center

Security Center gives a centralized view of all of your security alerts. Security Center ranks security alerts based on their severity. Security Center also combines related alerts as much as possible into a single security incident.

View your security alerts through the **Security alerts** pane under the **General** section on the main menu.

![Screenshot of Security alerts overview.](../media/6-security-center-update-05.png)

You drill down into specific security incidents by selecting an incident.

![Screenshot of incident details.](../media/6-security-center-update-06.png)

From here, you can see the list of alerts that the incident holds.

![Screenshot of incident with alert list.](../media/6-security-center-update-07.png)

You request more information about a specific alert by selecting one.

![Screenshot of alert details.](../media/6-security-center-update-08.png)

You have the responsibility to dismiss alerts if no action is required, such as if there are false positives. You also need to act to address known attacks and block, for example, known malicious IP addresses. Also, you must decide which alerts require more investigation.

![Screenshot of alert status.](../media/6-security-center-update-09.png)

Security Center helps you respond to threats faster, and in an automated way by taking action. Actions include mitigating the threat, preventing future attacks, triggering an automated response with Logic Apps, or suppressing similar alerts.

![Screenshot of alert action options.](../media/6-security-center-update-10.png)