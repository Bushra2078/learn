Let's create another interrupting bot to help patients check their temperature and other vitals, if they haven't so far. The patient can reach this bot by entering the word **temperature**. That entry will break the flow of the original bot and run this new one. 

To create this bot, we'll build a breaking scenario and then create a model.

## Create a breaking scenario

1. Configure the scenario with the following details:  

   :::image type="content" source="../media/4-edit-scenario.png" alt-text="Screenshot that shows the selections for configuring a breaking scenario.":::

   - **Name:** Enter **Interrupting Bot 2**.
   - **Description:** Enter **An interrupting bot which checks the patient's temperature and breaks**.
   - **Scenario ID:** Enter **temperature**.  
   - **Returning Message:** Enter **Please start your process again**.  
   - **Interrupting scenario:** Turn on this toggle.
   - **Breaking scenario:** Turn on this toggle, because we need to see how the breaking scenario works.

1. Select **Update**.

:::image type="content" source="../media/4-bot-designer.png" alt-text="Screenshot of the designer view of a bot that collects temperature information.":::

## Create a model for the breaking scenario

Our bot will give messages about the temperature of the patient. We're using only prompt, yes/no, and statement blocks to build the bot.  

1. Configure the model with the following details:

   :::image type="content" source="../media/4-model-details.png" alt-text="Screenshot that shows the regular expression configuration for the model.":::

   - **Name:** Enter **temperature**.
   - **Description:** Enter **temperature**.
   - **Method:** Select **RegEx**.
   - **Regular Expression:** Enter `/^(temperature)?(!)?\s*$/i`.
   - **Intent mapping:** Enter **temperature**.

1. From the dropdown list, select **temperature**. Then select **Create**.

When we run the main bot, and the patient enters the word **temperature**, the flow breaks and Interrupting Bot 2 starts running.  

:::image type="content" source="../media/4-flow-break.png" alt-text="Screenshot that shows the Web Chat preview of the temperature bot.":::

:::image type="content" source="../media/4-flow-resume.png" alt-text="Screen shot that shows redirecting to the main bot.":::

The bot displays the temperature for the patient and asks if they want to check more vitals. When the patient chooses **no**, the bot ends the scenario and never returns to the main bot.
