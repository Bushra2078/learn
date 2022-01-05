You have an application for the sales team in your global company. Each team member has your app installed on a mobile device to use for sales. An Azure web service hosts the business logic implemented for your application and stores information in an Azure SQL Database. Each  geographical region has its own instance of the web service.

You've identified the following scenarios for message exchange between the mobile app and the web service:

- Messages that relate to individual sales must be sent to the web service instance in the user's region.
- Messages that relate to sales performance must be sent to all instances of the web service.

You've decided to implement a Service Bus queue for the first use case, and the Service Bus topic for the second use case.

In this exercise, you'll create a Service Bus namespace, which will contain both a queue and a topic with subscriptions.

## Create a Service Bus namespace

Start by creating the namespace. In Azure Service Bus, a namespace is a container for queues, topics, and relays. Each namespace has a unique, fully qualified domain name, with primary and secondary shared access signature (SAS) encryption keys. A sending or receiving component must provide a SAS key to gain access to objects in a namespace.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same login you used to activate the sandbox.

1. Under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. Enter **Service Bus** in global search, and in the results, on **Service Bus** published by Microsoft for Azure, select **Create**. The **Create namespace** pane appears.

1. On the **Basics** tab, enter or select the following values for each setting.

    | Setting | Value | Description |
    | ------- | --- | ---- |
    | **Project Details** |
    | Subscription | Concierge subscription | The subscription under which this new function app is created. |
    | Resource group | <rgn>[Sandbox resource group name]</rgn> | Name of the resource group in which to create your Service Bus namespace. In this exercise, we'll create the namespace in the resource group that was assigned when we activated the sandbox. |
    | **Instance Details** |
    | Namespace name | [Globally unique name] | Enter a name that is unique within Azure.<br>If you want to use this format, _salesteamapp_<_Company_><_year_> your Namespace name would look like this: _salesteamappContoso2021_ |
    | Location | Select from the dropdown list | Choose from the free *Sandbox regions* listed below. |
    | Pricing tier | Standard | The recommended pricing tier for this exercise. |

    [!INCLUDE[Sandbox Regions](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review + create**.

    :::image type="content" source="../media/3-create-namespace-2.png" alt-text="Screenshot of the Create namespace pane showing validation passed and with Review + create button highlighted.":::

1. After validation succeeds, select **Create** to create your Service Bus namespace.

    :::image type="content" source="../media/3-create-namespace-3.png" alt-text="Screenshot of the Create namespace pane, showing validation succeeded and Create button highlighted.":::

## Create a Service Bus queue

Let's add a queue for messages about individual sales to your namespace.

1. After deployment completes, select **Go to resource**. The Overview pane for the Service Bus Namespace you created appears.

1. In the command bar, select **+ Queue**. The  **Create queue** pane appears.
    
    :::image type="content" source="../media/3-create-queue.png" alt-text="Screenshot of Service Bus Namespace and Create queue panes with Queue and Create highlighted.":::

1. In the **Name** text box, enter `salesmessages`, and then select **Create**.  
    
    When the message queue has been created, `salesmessages` is listed under the **Queues** tab at the bottom of the Service Bus Namespace.

## Create a Service Bus topic and subscriptions

You also want to create a topic that will be used for messages that relate to sales performance. Each instance of the business logic web service subscribes to this topic, and each sales performance message will be delivered to all web service subscriptions.

Let's add a Service Bus topic and subscriptions.

1. In the command bar of the **Service Bus Namespace** pane, select **+ Topic**. The **Create topic** pane appears.

    :::image type="content" source="../media/3-create-topic.png" alt-text="Screenshot of the Service Bus Namespace and Create topic panes with Topic and Create highlighted.":::

1. In the **Name** text box, enter *salesperformancemessages*, and then select **Create**. 

1. When the topic has been created, **salesperformancemessages** is listed under **Topics** tab at the bottom of the Service Bus Namespace.
 
1. You can add or remove subscriptions to a queue or topic from the respective tab in the Service Bus Namespace, or you can use the Entities menu. Let's use the menu option. In the Service Bus Namespace menu on the left, scroll down to **Entities**, select **Topics**, and in the list of topics, select **salesperformancemessages**. 
 
1. The sales performance messages Service Bus Topic pane appears. 

1. In the command bar, select **+ Subscription**. The **Create subscription** pane appears.

1. For **Name**, enter **Americas**; for **Max delivery count**, enter **100**; and then select **Create**. 
 
    The `salesperformancemessages` Service Bus Topic appears with the **Americas** subscription listed in the Subscriptions section at the bottom of the pane.

1. Let's add a second subscription. In the command bar, select **Subscription**. The **Create subscription** pane appears.

1. For **Name**, enter **EuropeAndAsia**; for **Max delivery count**, enter **100**; and then select **Create**.

    The Subscriptions section of the `salesperformancemessages` Service Bus Topic for your sales team app now lists two subscriptions.
  
You have built the infrastructure to use a Service Bus to increase the resilience of your distributed application. You've created a queue for messages about individual sales, and a topic for messages about sales performance. You've added multiple subscriptions to the topic so topic messages can be delivered to multiple web services around the world.
