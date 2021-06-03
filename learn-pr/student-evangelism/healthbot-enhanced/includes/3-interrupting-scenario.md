In general, an interruption is a disturbance in a process. Similarly, an interrupting scenario causes a break in the flow of the scenario. It allows us to jump between two different scenarios. 

Initially, the main scenario is where the bot runs. Due to a keyword that it encounters, the bot switches to the subscenario that's defined as a model. After the subscenario is complete, the bot then switches back to the main scenario with an interrupt message that's defined during the configuration.

## Create a scenario for an interrupting bot

1. Configure the scenario with the following details:

   :::image type="content" source="../media/3-create.png" alt-text="Screenshot that shows the selections for configuring a scenario.":::

   - **Name**: Enter any unique name. We've used **Intermediate Bot 1** in this example.
   - **Description**: Enter a simple description of what the bot will do. We've used **Simple bot to collect the vitals from patient**.
   - **Scenario ID**: Enter a unique ID. We've used **vitals**.
   - **Returning Message**: Enter a message that appears while the bot is returning to the main flow. We've used **Let's continue from here**.
   - **Interrupting scenario**: Turn on this toggle.
   - **Breaking scenario**: Turn off this toggle, because we want this bot to return to the main flow.

1. Select **Create**.

We've now created a bot that collects basic information (name, age, height, weight, temperature) from the patient.

:::image type="content" source="../media/3-intermediate-bot-1.png" alt-text="Screenshot of the designer view of a bot that collects basic information.":::

Along with creating a new scenario for the bot, we need to create a new model.

## Create a model for the interrupting scenario

1. On the menu bar, go to the **Language** tab. Then select **Models**.  
1. On the **Language models** page, select **New**.

   :::image type="content" source="../media/3-new-language-model.png" alt-text="Screenshot of the page for creating language models in Azure Health Bot.":::

1. Configure the model with the following details:  

   :::image type="content" source="../media/3-model-details.png" alt-text="Screenshot that shows the selections for model configuration.":::

   - **Name**: Provide a name for the model. In this example, we've used **vitals**.
   - **Description**: Provide a suitable description. We've used **vitals collection**.
   - **Method**: Three methods are available. For this model, select **RegEx**.
   - **Regular Expression**: Provide a suitable JavaScript expression. We've used `/^(vitals)?(!)?\s*$/i`.
   - **Intent mapping**: This is a unique intent triggered when the utterance is matched with the provided RegEx pattern. We've mapped it as shown in the preceding screenshot.

1. From the dropdown menu, select **vitals**.

1. Select **Create**.

## Make changes to the basic bot

In this module, we'll use the basic bot scenario that we just created to demonstrate the interrupting and breaking scenarios. Before moving ahead, we need to make some changes to the scenario. 

:::image type="content" source="../media/3-add-block.png" alt-text="Screenshot that shows changes to the basic bot.":::

Open the basic bot scenario and add a **Prompt** item immediately to the right of the switch branches. The prompt will ask for the entry of the **vitals** keyword to record the patient's information. The **vitals** keyword triggers an interrupting scenario.

:::image type="content" source="../media/3-prompt-details.png" alt-text="Screenshot that shows the prompt scenario step.":::

While the main bot is running, this scenario is triggered when the patient enters the word **vitals** as shown in the following screenshot. The word **vitals** breaks the current flow of the main bot and takes the patient to the new scenario for recording their information.  

:::image type="content" source="../media/3-vitals-trigger.png" alt-text="Screenshot of Web Chat, with the main scenario getting interrupted with the vitals keyword.":::

:::image type="content" source="../media/3-resume-topic.png" alt-text="Screenshot of the interrupting scenario returning to the parent scenario.":::

After the patient gives all the information that bot asks for, Intermediate Bot 1 returns to the basic bot to continue with the appointment process, with a returning message.
