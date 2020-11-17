You can configure Azure Sentinel playbooks at Contoso to respond to security threats. 

## Explore the Playbooks page

You can automate responses to threats on the **Playbooks** page. On this page, you can see all the playbooks that are created from Azure Logic Apps. The column **Trigger kind** presents what type of connectors are used in the logic app.

You can use the header bar, as displayed in the following diagram, to create new playbooks or to enable or disable existing playbooks.

:::image type="content" source="../media/04-PLaybooks-header.PNG" alt-text="Screenshot of the header bar." border="true":::

The header bar provides the following options:

- Use the **Add Playbook** button to create a new playbook.
- Use the **Refresh** button to refresh the display, for example, after you create a new playbook.
- Use the drop-down time field to filter the status of the running of the playbooks. 
- The **Enable**, **Disable**, and **Delete** buttons are only available if you select one or more logic apps.
- Use the **Logic Apps documentation** button to review links to official Microsoft documentation for more information on logic apps.

Contoso wants to use automated actions to prevent suspicious users from accessing their network. As their security administrator, you can create a playbook to implement this action. To create a new playbook, select **Add Playbook**. You will be directed to the page where you should create a new Logic App by providing inputs for the following settings:

- **Subscription**. Select the subscription that contains the Azure Sentinel. 
- **Resource Group**. You can use an existing resource group or create a new one.
- **Logic App name**. Provide a descriptive name for the logic app.
- **Location**. Select the same location as where your Log Analytics workspace is located.
- **Log Analytics**. If you enable log analytics, you can get information about playbook&#39;s runtime events.

After providing these inputs, select **Review + Create** button, and then select **Create**.

## Logic Apps Designer

Azure Sentinel creates the Logic App, and then you are directed to the **Logic App Designer** page.

The Logic App Designer provides a design canvas that you use to add a trigger and actions to your workflow. For example, you can configure the trigger to come from the Azure Sentinel Connector when a new security incident is created. The Logic App Designer page provides many predefined templates that you can use. However, to create a playbook, you should start with the **Blank Logic App** template to design the logic app from scratch.

The automated activity in the playbook is initiated by the Azure Sentinel trigger. You can search for the Azure Sentinel trigger in the search box of the design canvas, and then select one of the following two available triggers:

- When a response to an Azure Sentinel alert is triggered
- When Azure Sentinel incident creation rule was triggered

Opening Azure Sentinel Connector for the first time prompts you to **Sign in** to your tenant either with a user account from Azure Active Directory (Azure AD) or with Service Principal. This establishes an API connection to your Azure AD. The API connections store variables and tokens that are required to access the API for the connection, such as Azure AD, Office 365, or similar.

:::image type="content" source="../media/04-Sign-In-ADTenant.PNG" alt-text="Screenshot of sign-in to the Azure AD tenant." border="true":::

Each playbook starts with a trigger followed by actions that define the automated response on a security incident. You can combine actions from an Azure Sentinel connector with other actions from other Logic Apps connectors.

For example, you can add the trigger from an Azure Sentinel connector when an incident is triggered, follow it with an action that identifies the entities from the Azure Sentinel alert, and then another action that sends an email to an Office 365 email account. Azure Sentinel creates every action as a **New Step** and defines the activity that you are adding in the logic app.

The following screenshot displays the incident triggered by Azure Sentinel connector, which detects a suspicious account and sends an email to the administrator. 

:::image type="content" source="../media/04-Log-App-Designer.PNG" alt-text="Screenshot of the logic app with actions." border="true":::

Each step in the workflow design has different fields that you must fill. For example, the **Entities - Get Accounts** action requires you to provide the list of entities from an Azure Sentinel alert. An advantage of using Azure Logic Apps is that you can provide this input from the **Dynamic content** list, which is populated with the outputs of the previous step. For example, the Azure Sentinel connector trigger **When a response to Azure Sentinel Alert is triggered** provides dynamic properties such as **Entities, Alert Display name**, which you can use to fill the inputs.

:::image type="content" source="../media/04-Dynamic-Content.PNG" alt-text="Screenshot that displays dynamic content." border="true":::

You can also add a control actions group that lets your logic app make decisions. The control actions group can include logical conditions, switch case conditions, or loops. 
A **condition** action is an **if** statement that lets your app perform different actions based on the data you're processing. It consists of a Boolean expression and two actions. At runtime, the execution engine evaluates the expression and chooses an action based on whether the expression is true or false.
For example, Contoso receives a large volume of alerts, many of them with recurring patterns, which cannot be processed or investigated. Using real-time automation, the Contoso SecOps teams can significantly reduce their workload by fully automating the routine responses to recurring types of alerts.
The following screenshot presents a similar situation, where based on the user input, the playbook can change the status of the alert. The control action intercepts the user input, and if the expression evaluates to be a true statement, the playbook changes the status of the alert. In case the control action evaluates the expression to be false, the playbook can run other activities, such as sending an email as depicted in the following screenshot.

:::image type="content" source="../media/04-Condition.PNG" alt-text="Screenshot that displays the logic app condition." border="true":::

After you provide all the steps in the Logic Apps Designer, save the logic app to create a playbook in Azure Sentinel.

## The Logic Apps page in Azure Sentinel

The playbooks you create appear on the **Playbooks** page, and you can further edit them. From the **Playbooks** page, you can select an existing playbook and that will open the Logic Apps page for that playbook in Azure Sentinel.

You can run several actions on the playbook from the Logic Apps header bar:

- **Run Trigger**. Use to run the logic app to test the playbook.
- **Refresh**. Use to refresh the status of the logic app to retrieve the status of the activity.
- **Edit**. Use to further edit the playbook in the **Logic Apps Designer** page.
- **Delete**. Use to delete the logic app if you do not need it.
- **Disable**. Use to temporarily disable the logic app to prevent the action from being performed even if the trigger is activated.
- **Update Schema**. Use to update the schema of the logic app after a significant change in the logic.
- **Clone**. Use to make a copy of the existing logic app, and then use that as a basis for further modification.
- **Export**. Use to export the logic app to Microsoft Power Automate and Microsoft Power Apps.

The **Essentials** section  displays descriptive information about the logic app. For example, the logic app definition displays the number of triggers and actions that the logic app provides.
You can use the **Summary** section, to review summarized information about the logic app. From this section, you can select the logic app link to open it in the Logic Apps Designer, or review the trigger history.
The **Runs history** section displays the previous runs of the logic app and whether they succeeded or failed.
