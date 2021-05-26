The Azure Health Bot service supports several built-in scenarios. For example, the bot can triage a medical condition or find information about a disease. You can also design custom scenarios in the Health Bot service that fit your organization's needs. 

## Get started with a custom scenario

1. If you don't have an access to the Azure Health Bot service, [create a free account](https://azure.microsoft.com/services/bot-services/health-bot/?azure-portal=true).

1. Sign in to the Health Bot portal.
   
1. Select **Create new scenario**.

   :::image type="content" source="../media/2-create-new.png" alt-text="Screenshot that shows the link for creating a new scenario.":::

1. In the **New Scenario** form, fill in the following details.

   :::image type="content" source="../media/2-new-scenario-details.png" alt-text="Screenshot that shows fields for a new scenario.":::

   - **Name**: Choose a name for your custom bot. Try to keep it meaningful so that it's easy to find when you're searching for it.

   - **Description**: Enter a brief explanation of your bot so that others will know why you're creating it.

   - **Scenario ID**: Enter a unique ID for the bot. It's case sensitive and does not allow spaces. 
   
   - **Returning Message**: Enter a message that appears if the scenario is interrupted and then the user returns.  

   - **Interrupting scenario**: Select this toggle if you want to allow the scenario to be interrupted.

1. Select **Create**. Configuration of the scenario might take some time.

After the scenario is configured, a screen like the following one appears.

:::image type="content" source="../media/2-configured.png" alt-text="Screenshot that shows the screen that appears after a new scenario is configured.":::

The fields, visual editor, and elements provided in the Scenario Editor allow you to author, test, and debug scenarios.

The screen has four main areas. On the **Designer** tab, you can see the code of the block that you've designed. Select the **Code** tab to see the JSON format of the block.

:::image type="content" source="../media/2-code.png" alt-text="Screenshot that shows the Designer and Code tabs.":::

