Some incidents at Contoso might require further investigation before you run a playbook. Azure Sentinel allows you to run playbooks on demand to facilitate in-depth investigations. 

## Run a playbook on demand

You can configure playbooks to run on demand based on incident details, to trigger specific steps as part of the investigation, or to conduct some remediation action.

Consider the scenario where suspicious users are prevented from accessing corporate resources. As the Contoso security administrator, you find one false positive incident. Some users at Contoso were accessing resources over a VPN connection from remote computers while being connected to the office computers at the same time. Microsoft security graph <!-- Marjan on the website, I see this as Microsoft Graph Security API. Is this the same or a different prduct? We need to use casing as it appears in the formal product name--> received signals and based on the vulnerability that detects potential threat from atypical travel locations, it tagged the users as medium risk.

You can use a playbook that can automatically dismiss this risky user property in Azure AD.

## Azure Sentinel repository on GitHub

[Azure Sentinel repository on GitHub](https://github.com/Azure/Azure-Sentinel) contains ready to use playbooks to help you automate responses on incidents. These playbooks are defined with Azure Resource Manager (ARM) templates that use Logic App Azure Sentinel triggers.

For the scenario described earlier, you can use the **Dismiss-AADRiskyUser** playbook, which is located in the Azure Sentinel repository on GitHub, and deploy it directly in your Azure subscription.

For each deployment from GitHub, you first must authorize each connection in the playbook before you edit them in Logic Apps Designer. Authorization will create an API connection to the appropriate connector and store the token and variables. You can locate the API connection in the resource group where you created the logic app.
The name of each API connection is appended with **azuresentinel** prefix. You can also edit the connection in the Logic Apps Designer when you edit the logic app.

:::image type="content" source="../media/05-Api-connection.PNG" alt-text="Screenshot that depicts the authorization of the API connection." border="true":::

## Attach a playbook on existing incident

After your playbook is ready, you can open the **Incident** page in Azure Sentinel, and then select the existing incident. In the details pane on the right, you can select **View full details** to explore the properties of the incident. From the **Alerts blade,** you can select **View playbooks**, and then you can run one of the existing playbooks.
The following screenshot depicts the suspicious user activity example for which you can attach the **Dismiss-AADRiskyUser** playbook.

:::image type="content" source="../media/05-Investigate.PNG" alt-text="Screenshot of the Incident page." border="true":::

After you have investigated the incident, you can choose to run the playbook manually to respond to a security threat.
