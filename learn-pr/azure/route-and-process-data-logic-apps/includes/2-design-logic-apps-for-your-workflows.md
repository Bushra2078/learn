Implementing any business process is difficult because you need to make diverse services work together. Think about everything your company uses to store and process data: Salesforce, Office 365, Oracle, Twitter, YouTube, Dropbox, Google services, Azure Cognitive Services, and so on. How do you integrate all these products?

Azure Logic Apps gives you pre-built connectors to access hundreds of services. You put these components together in any combination that you need. For example, in this athletic shoe company scenario, we want to monitor social media reaction to our new basketball shoe product. We'll build a logic app workflow to integrate Twitter, Azure Cognitive Services, SQL Server, and Outlook email.

In this unit, we'll plan the sequence of steps needed to implement a business process. Then we'll map those steps to the connectors available in Azure Logic Apps. Finally, we'll assemble the parts into a workflow using the designer in Azure Logic Apps. The following illustration shows an overview of the app  development process.

:::image type="content" source="../media/app-design-process.png" alt-text="An illustration showing the typical sequence of activities to create a logic app workflow. The process has five steps. First, plan your business process. Second, identify the type for each step in your process. Third, decide which component will implement each step. Fourth, use the designer to build your workflow from the components. Fifth, save your design. Your app will now run automatically in the cloud." border="false":::

The following sections describes each of these five steps in the app development process:

## Plan your business process

The first step to creating a logic app workflow is planning the steps of your business process. In the social media monitoring scenario, the steps are as follows:

- Detect tweets about the product
- Analyze the sentiment
- Store a link to positive tweets
- Email customer service for negative tweets

Typically, you can use a flowchart to capture the steps of the process. The following illustration shows the flowchart for the social media monitoring app.

:::image type="content" source="../media/social-media-monitor-workflow.png" alt-text="An illustration showing a flowchart for the way the fictional shoe company processes tweets written about their product." border="false":::

## Identify the type for each step in your process

The steps in a business process perform different types of operations. Some respond to external events, some process or store data, and others make decisions based on the data. Azure Logic Apps uses the terms *trigger*, *action*, and *control action* for these three categories.

For example, in our social media monitoring scenario, a *trigger* starts the process when a new tweet is posted, an *action* performs a task such as analyzing the sentiment, and a *control action* makes a decision based on the sentiment score. The following illustration shows the type for each step in the social media monitoring app.

:::image type="content" source="../media/social-media-step-types.png" alt-text="An illustration showing the flowchart for the shoe company social media monitoring app. Each step is labeled as a trigger, action, or control action." border="false":::

## Map your steps to Logic Apps components

When deciding which pre-built component to implement, we need to be clear about component types. Let's be more formal about the definitions of the component types:

- A *trigger* is an event that occurs when a specific set of conditions is satisfied. Triggers activate automatically when the conditions are right (for example, when a timer expires or data becomes available). Every logic app must start with a trigger. In our example, we'll trigger the app when a new tweet mentions our product.

- An *action* is an operation that executes one of the tasks in your business process. Actions run when a trigger activates or another action completes. Our social media monitor app has three actions: detect sentiment, insert database row, and send email.

- *Control actions* are special built-in actions that let you add decisions and loops to your app. Our example will use a control action to branch based on the sentiment score.

A group of related triggers and actions are packaged inside a *connector*. Conceptually, you can think of a connector as a component that lets you access an external service. For example, the Twitter connector lets you send and receive tweets while the Microsoft 365 Outlook connector allows you to manage your email, calendar, and contacts. The following illustration shows the Twitter connector with its operations divided into the two categories.

:::image type="content" source="../media/twitter-connector-details.png" alt-text="An illustration showing the triggers and actions available in the Twitter connector." border="false":::

Your job is to map each task in your flowchart to Logic Apps triggers and actions. The following illustration shows the connectors we'd use in the social media app with the relevant triggers and actions highlighted.

:::image type="content" source="../media/social-media-design-process.png" alt-text="Illustration showing the operations available in the connectors used by the social media monitor app. Specifically, it shows the Twitter connector, the Text Analytics connector, the SQL Server connector, and the Office 365 Outlook connector, and a graphical representation for each of the control actions. The trigger and actions used in the social media monitor app are highlighted." border="false":::

## Define your app using the Logic Apps Designer

The Logic Apps Designer is a graphical tool for creating your workflows. It lets you pick from a gallery of connectors that contain the triggers and actions you can use in your app. You'll use the graphical Logic Apps Designer to arrange the trigger, actions, and control actions. The following screenshot shows the designer with the completed application.

:::image type="content" source="../media/social-media-app-designer-view.png" alt-text="A screenshot showing Logic Apps Designer with the completed social media monitor app. The app begins with the Twitter trigger. It has three actions: detect sentiment, insert row, and send email. A control action determines whether the insert row or send email action executes based on the score of the **Detect sentiment** action." border="false":::

When you save your app, it will be live and will run automatically whenever the trigger activates.

## Knowledge check

The questions in this knowledge check relate to the workflows shown in the following illustrations. Each question will ask you to evaluate one of the workflows to find the correct answer.

| Social media workflow | Email attachment processing workflow |
| --- | --- |
| :::image type="content" source="../media/social-media-monitor-logic-app.png" alt-text="An illustration of a social media monitoring workflow. This workflow triggers when a user posts a new tweet that mentions a specific product. It sends the text of the tweet through Text Analytics to determine sentiment. If the sentiment score is greater than 0.7, then a row containing the tweet is added to a database. If the tweet is rated less than 0.7, an email will be sent to customer support." border="false"::: | :::image type="content" source="../media/email-workflow.png" alt-text="An illustration of an email attachment processing workflow. This workflow is triggered when a new email arrives. Next, there is a *if* statement that checks if the email has an attachment. If there are no attachments on the email, the workflow ends. If there are attachments, the workflow creates a blob for the email body. Next, a *foreach* loop creates a blob for every attachment. Finally, an email is sent for review." border="false"::: |
| | |
