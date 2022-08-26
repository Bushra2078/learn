::: zone pivot="nodeexpress"

In Visual Studio Code, you can use the Azure App Service extension to create and deploy webapps to Azure.

Suppose you have started to create the new website that will promote the new video game launch. The new site has been written in JavaScript and uses Node.js and Express.js. You've decided that the completed website will be hosted in Azure App Service. Now, you want to create that instance of App Service and deploy the first version of the website to it.

In this unit, you'll use Visual Studio Code to deploy the Express.js site, which you created in the last exercise, to Azure.

## Install the Azure App Service extension in Visual Studio Code

The **Azure App Service** extension is not installed by default in Visual Studio Code. Let's start by installing it:

1. In Visual Studio Code, on the **View** menu, select **Extensions**.
1. In the **Search Extensions in Marketplace** textbox, type **Azure App Service**, and then select the **Azure App Service** extension.

    :::image type="content" source="../media/5-add-azure-app-service-extension-vsc-update.png" alt-text="Add the Azure App Service extension in Code." loc-scope="vs-code":::

1. Select **Install**.

## Sign in to your Azure account through the Azure explorer

To view and make changes in your Azure subscription, first authenticate yourself:

1. In Visual Studio Code, to open the **Azure** explorer, on the **View** menu, select **Open View...** and then select **Azure**.
1. In the **AZURE** explorer, select **Sign in to Azure...**.

    :::image type="content" source="../media/5-sign-in-to-azure-vsc-update.png" alt-text="Sign into Azure in Code." loc-scope="vs-code":::

1. Sign in with the same credentials you used to set up the sandbox and then close the browser page.

## Create a new Azure App Service Web App by using the Azure App Service extension

Now that the extension is installed, we can use it to create an instance of App Service, as well as a resource group, and a service plan, in your subscription:

1. In Visual Studio Code, in the **Azure** explorer, under **RESOURCES**, expand the **Concierge Subscription**.
1. Right-click **App Services**, and then select **Create New Web App... (Advanced)**.
1. In the first page of the **Create new web app** wizard, type a globally unique name for the app, such as **LaunchCountDown&lt;your initials&gt;**, and then press <kbd>Enter</kbd>.

    :::image type="content" source="../media/5-create-new-web-app-wizard-1-of-6.png" alt-text="Create new web app." loc-scope="vs-code":::

1. Select the resource group **<rgn>[sandbox resource group name]</rgn>**, select **Node 14 LTS**, and then select **Linux**.
1. Select the **Central US** region.
1. Select **Create new App Service plan** and name the new plan **LaunchCountDownPlan**.
1. Select the **Free (F1)** pricing tier and skip creating a new Application Insights resource. Visual Studio Code creates an App Service plan and webapp in your Azure subscription.

## Deploy the Express.js webapp to Azure App Service

Now, you can deploy your Express.js site to Azure:

1. In Visual Studio Code, in the **Azure** explorer, right-click the webapp you created, and then select **Deploy to Web App**.
1. Click **Browse**, locate the **countdownExpressApp** folder in your home folder, and then click **Select**.
1. If you are asked if you would like to update your workspace configuration, select **No, and don't show again**.
1. If you are asked if you are sure, click **Deploy**. If you are asked if you always want to deploy this workspace to App Service, click **Yes**.
1. When the deployment is complete, select **Browse Website**. Then Azure website is displayed in your browser. Notice that the website is hosted in the **azurewebsites.net** domain.

    :::image type="content" source="../media/5-deployed-website-vsc-update.png" alt-text="Express.js website hosted in Azure." loc-scope="other":::

::: zone-end

::: zone pivot="pythonflask"

In Visual Studio Code, you can use the Azure App Service extension to create and deploy webapps to Azure.

Suppose you have started to create the new website that will promote the new video game launch. The new site has been written in Python and uses Flask. You've decided that the completed website will be hosted in Azure App Service. Now, you want to create that instance of App Service and deploy the first version of the website to it.

In this unit, you'll use Visual Studio Code to deploy the Python site, which you created in the last exercise, to Azure.

## Install the Azure App Service extension in Visual Studio Code

The **Azure App Service** extension is not installed by default in Visual Studio Code. Let's start by installing it:

1. In Visual Studio Code, on the **View** menu, select **Extensions**.
1. In the **Search Extensions in Marketplace** textbox, type **Azure App Service**, and then select the **Azure App Service** extension.

    :::image type="content" source="../media/5-add-azure-app-service-extension-vsc-update.png" alt-text="Add the Azure App Service extension in Code." loc-scope="vs-code":::

1. Select **Install**.

## Sign in to your Azure account through the Azure explorer

To view and make changes in your Azure subscription, first authenticate yourself:

1. In Visual Studio Code, to open the **Azure** explorer, on the **View** menu, select **Open View...** and then select **Azure**.
1. In the **AZURE** explorer, select **Sign in to Azure...**.

    :::image type="content" source="../media/5-sign-in-to-azure-vsc-update.png" alt-text="Sign into Azure in Code." loc-scope="vs-code":::

1. Sign in with the same credentials you used to set up the sandbox and then close the browser page.

## Create a new Azure App Service Web App by using the Azure App Service extension

Now that the extension is installed, we can use it to create an instance of App Service, as well as a resource group, and a service plan, in your subscription:

1. In Visual Studio Code, in the **Azure** explorer, under **RESOURCES**, expand the **Concierge Subscription**.
1. Right-click **App Services**, and then select **Create New Web App... (Advanced)**.
1. In the first page of the **Create new web app** wizard, type a globally unique name for the app, such as **LaunchCountDown&lt;your initials&gt;**, and then press Enter.

    :::image type="content" source="../media/5-create-new-web-app-wizard-1-of-6.png" alt-text="Create new web app." loc-scope="vs-code":::

1. Select the resource group **<rgn>[sandbox resource group name]</rgn>** and then select **Python 3.8**. 
1. Select the **Central US** region.
1. Select **Create new App Service plan** and name the new plan **LaunchCountDownPlan**.
1. Select the **Free (F1)** tier and skip creating a new Application Insights resource. Visual Studio Code creates an App Service plan and webapp in your Azure subscription.

## Deploy the Python webapp to Azure App Service

Now, you can deploy your Python site to Azure:

1. In Visual Studio Code, in the **Azure** explorer, right-click the webapp you created, and then select **Deploy to Web App**.
1. Click **Browse**, locate the **countdownFlaskApp** folder in your home folder, and then click **Select**.
1. If you are asked if you would like to update your workspace configuration, select **No, and don't show again**.
1. If you are asked if you are sure, click **Deploy**. If you are asked if you always want to deploy this workspace to App Service, click **Yes**.
1. When the deployment is complete, select **Browse Website**. Then Azure website is displayed in your browser. Notice that the website is hosted in the **azurewebsites.net** domain.

    :::image type="content" source="../media/5-deployed-website-vsc-update.png" alt-text="Python website hosted in Azure." loc-scope="other":::

> [!NOTE]
> If you see a message titled "Hey, Python developers!", you may need to refresh a couple of times while the app is compiling on the server.

::: zone-end
