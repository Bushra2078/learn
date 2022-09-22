In this unit, you run the app in the Kudu console, view the application event log in the Kudu console, and then view the application event log in the Azure portal.

## Run the app in the Kudu console

You can run the app in Kudu console to discover useful information:

1. Go to the [Azure portal](https://portal.azure.com/learn.learn.microsoft.com?azure-portal=true).

1. In the Azure portal, search for and select the **HotelApp-####** app you created, replacing #### with the name of your app.

   :::image type="content" source="../media/application-search.png" alt-text="Screenshot that shows how to search for and select your HotelApp application in the Azure portal.":::

1. In the left menu under **Development Tools**, select **Advanced Tools**.

1. In **Advanced Tools**, select **Go** to open the Kudu console in a new window.

1. In the Kudu **Debug console** menu, select **CMD**.

1. At the command prompt, run the following commands:

   `cd..`

   `D:`

   `cd \Program Files\dotnet`

1. Run the app: `dotnet \home\site\wwwroot\HotelApp.dll`

The console output from the app, showing any errors, is piped to the Kudu console.  The error message shows an error like in the following example:

:::image type="content" source="../media/run-app-kudu-console.png" alt-text="Screenshot that shows the expected app errors in the Kudu console.":::

## Access the application event log in the Kudu console

Still in the Kudu debug console where you ran the app, complete these steps to view the Kudu event log file:

1. In the list of files above the debug console, select the **LogFiles** folder.

1. Select the edit icon to examine the events that are logged in the *eventlog.xml* file.

:::image type="content" source="../media/event-log-kudu-console.png" alt-text="Screenshot of a Kudu console with a list of folders and files on top and a DOS console displaying an error for a dotnet assembly.":::

## View the error and application event log in the Azure portal

Next, view the application event log in the Azure portal:

1. Go to the [Azure portal](https://portal.azure.com/learn.learn.microsoft.com?azure-portal=true).

1. In the Azure portal, search for and select the **HotelApp-####** app you created, replacing #### with the name of your app.

1. In the web app overview, for **URL**, select the link to view the startup error in the website:

   :::image type="content" source="../media/website-url.png" alt-text="Screenshot that shows how to find the U R L for a web app website.":::

   A startup error message like this example should be shown on the website for your web app:

   :::image type="content" source="../media/web-app-error-message.png" alt-text="Screenshot of the web app error message on the app website.":::

1. To get more information about the error, in the left menu, select **Diagnose and solve problems**.

1. Under **Troubleshooting categories**, select the **Diagnostic Tools** tile.

   :::image type="content" source="../media/advanced-tools-azure-portal.png" alt-text="Screenshot that shows selecting Diagnostic Tools in the Diagnose and solve problems pane.":::

1. In the left menu under **Support Tools**, select **Application Event Logs**.

1. In the **Source** column, find the **IIS AspNetCore Module V2** or **.NET Runtime** error event. Select the event to view the error log and discover information about the error:

   :::image type="content" source="../media/event-log-azure-portal.png" alt-text="Screenshot that shows the application error in the application event log in the Azure portal.":::
