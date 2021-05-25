In this exercise, we'll create our social media logic app using the Azure portal. We'll add a Twitter trigger using the Logic Apps Designer. The following illustration shows a conceptual view of the app with the part that we'll work on highlighted.

![An illustration showing the triggers and actions in the social-media monitor logic app. The first step is a Twitter trigger labeled **When a new tweet is posted**. This trigger is highlighted to indicate that is the part of the app that will be completed in this exercise.](../media/exercise-add-trigger.png)

## Locate the Azure logic app resource

The first thing we need to do is create an Azure logic app. To do that, we need to locate the Azure Logic Apps resource type in the Azure portal.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account you used to activate the sandbox.

1. On the Azure portal menu or from the home page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the search box, enter **Logic app**. Select **Logic App (Consumption)**. The **Logic App (Consumption)** pane appears.

1. Select **Create**. The **Create Logic App (Consumption)** pane appears.

## Configure your Azure Logic App resource

Now that the Azure Logic Apps resource has been located, let's configure basic settings, like its resource group and location.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription |
    | Resource group | From the dropdown, select <rgn>[Sandbox resource group]</rgn> |
    | **Instance Details** |
    | Logic app name | Enter *ShoeTracker* |
    | Region | Select a location closest to you from the following list |

    [!INCLUDE [](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review + create**, and then select **Create**. Wait until the resource is deployed. The **Overview** pane for your Logic App appears.

## Use a template for your Azure logic app

When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch.

1. In the Overview pane of your newly-created logic app, select **Go to resource**. The **Logic Apps Designer** pane appears.

## Create a Twitter trigger

> [!NOTE]
> If you do not have a Twitter account and prefer not to create one, you can substitute the **When a feed item is published** trigger from the RSS connector. Set the **RSS feed URL** to `https://blog.feedspot.com/reuters_rss_feeds/`, the **Interval** to `1`, and the **Frequency** to `Minute`. The disadvantage of this approach is that new articles appear infrequently in RSS feeds so you may have to wait a while before this trigger activates.

Now that we have our logic app created, we need to add a trigger. We're going to use the **When a new tweet is posted** polling trigger from the Twitter connector. There are three required parameters:

- **Search text:** Text to look for in the tweet text. You can include a hashtag character at the beginning of the search text to search for hashtags.
- **Frequency:** Unit of time for search frequency. For example, `Second`, `Minute`, `Hour`, or `Day`.
- **Interval:** How often to search. For example, an interval of `3` and a frequency of `Hour` would check for new tweets every three hours.

Now, let's create the trigger and provide values for all required parameters.

1. In the connectors search box, enter *Twitter*.

1. Select the **When a new tweet is posted** trigger.

1. Sign in with your existing Twitter account.

1. In the **Search text**, enter a name of a product. Use the name of a product that is new and popular so that you get results quickly.

1. Enter *1* for **Interval**.

1. Select *Minute* for **Frequency**.

1. In the top menu bar, select **Save**. Your app will be live as soon as you save it.

## Examine the results of your Twitter trigger

At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the **Runs history** table.

1. Select **Overview** in the navigation menu. You may need to scroll horizontally to see the navigation menu or you can use your browser's search function to find the word "overview" on the page.

1. Select **Refresh** once a minute until you see a row in the **Runs history** table.

1. While you are waiting, locate the section in **Overview** labeled **EVALUATION**. Notice the text that looks something like **Evaluated 12 times, fired 3 times in the last 24 hours**. The term *evaluated* means the condition in your trigger was checked; you should see this increase once per minute since you're polling every minute. The term *fired* indicates the number of times the trigger conditions were satisfied; in our case, this number represents how many times the trigger found matching tweets.

1. After you see a row appear, select the row. Selecting a row will navigate your view to something that looks like the designer you used to create the trigger. This view lets you see the data that flowed through each step of this run of your app.

1. Select the Twitter trigger.

1. Examine the data in the **OUTPUTS** section. For example, locate the text of the matching tweet.

    > [!NOTE]
    > Select **Show raw outputs** if you would like to see the entire response in JSON.
