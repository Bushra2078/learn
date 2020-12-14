You have an ASP.NET Core web application running locally. In this exercise, you'll publish your application to Azure App Service.

## Publish your ASP.NET Core web app to Azure

1. In Solution Explorer, right-click on the **AlpineSkiHouse** project and select **Publish**.

1. In the dialog box that appears, choose **Azure** as your publish target, and then select the **Next** button to continue.

1. Select **Azure App Service (Windows)**, and then select the **Next** button to continue.

    > [!TIP]
    > ASP.NET Core apps are cross-platform. This means they support running on the Linux version of App Service with no code changes. However, the Linux version doesn't support a shared hosting model, so you'll be using a Windows App Service for this exercise.

1. In the **Subscription** dropdown, select **Concierge Subscription**.

1. Near the bottom edge of the dialog, select the **Create a new Azure App Service** link to open the **App Service (Windows)** dialog.

### Configure your new Azure App Service

1. If you're not already signed in, sign into Visual Studio with the account you're using with Microsoft Learn.

1. Enter the required information about your App Service plan.

    - **Name**: the name of your application. The name determines the URL of the published application, which will be https://&lt;AppName&gt;.azurewebsites.net. It must be a unique value. You may have to try out some different names to find one that is unique.

    - **Subscription**: The Azure subscription you wish to deploy the app to. Choose **Concierge Subscription**, which we provide to you through the sandbox.

    - **Resource Group:** Select the existing <rgn>[sandbox resource group name]</rgn> resource group.

    - **Hosting Plan:** The hosting plan specifies the location, size, and features of the web server farm that hosts your app.  For this exercise, create a new hosting plan.

        Click the **New** button next to the hosting plan. In the Configure Hosting Plan window that appears, change the **Size** to **Shared** and click OK.

1. Click the **Create** button to create your App Service resource in Azure. This action will take several seconds to complete.

1. After several seconds, the **App Service (Windows)** dialog window will disappear. Your new App Service displays in the list of App Service resources on the **Publish** dialog window. Press the **Finish** button to finish the creation of the publishing profile. The **Publish** dialog disappears.

1. Your new publishing profile appears in the dropdown near the top of the property page. Click **Publish** to publish the web app to App Service.

1. Congratulations! Your ASP.NET Core web application is now published and live. The final URL for your site is in the build output and also on the publishing page in Visual Studio.

1. To test your website, go to the URL indicated.

    :::image type="content" source="../media/5-WebPageLive.png" alt-text="Live site." loc-scope="vs":::

    > [!NOTE]
    > If you can't locate the URL from the output, navigate to https://&lt;AppName&gt;.azurewebsites.net, where &lt;AppName&gt; is the name you provided earlier. For example, **"https://alpineskihouse123.azurewebsites.net/"**.

You now have a live web app! Your Azure App Service plan has been created and the app is running and ready to accept updates.
  
