Suppose you have a simple Java web app that you've written in IntelliJ IDEA. You want to test the app in Azure, and you want to make the deployment as simple as possible so that your developers don't need to use extra tools. The Azure Toolkit for IntelliJ includes a wizard that makes it easier to deploy web apps.

In this exercise, you'll use the deployment wizard to deploy a web app to Azure.

## Sign into Azure

To explore your Azure resources, you must first sign into Azure. By signing in, you specify the subscription and directory where you want to create resources:

1. In **IntelliJ IDEA**, on the **View** menu, select **Tool windows** and then select **Azure Explorer**.

1. In the **Azure Explorer** window, select the **Azure Sign In** button:

    ![Azure Sign In button](../media/3-azure-signin-button.png)

1. Select **Device Login** and then select **Sign in**.

1. In the **Azure Device Login** page, select **Copy&Open**.

1. In the browser, press <kbd>CTRL-V</kbd> to paste the code, and then select **Next**.

1. Sign into your Azure account with your user credentials.

1. When you see the sign-in acknowledgment, close the browser window.

1. In **IntelliJ IDEA**, in the **Select Subscriptions** dialog, select the **Concierge Subscription**. This is a subscription created specifically for the sandbox.

    ![Azure Sign In button](../media/3-select-subscription.png)

The **Azure Explorer** now displays objects in your Azure subscription. You can explore the different types of objects, such as storage accounts.

## Configure and deploy the web app

Now, you can use the **Deploy to Azure** wizard to create a new app in Azure App Service and then deploy your project to it:

1. In IntelliJ IDEA, in the **Project** window, right-click the **AzureTests** project, select **Azure**, and then select **Deploy to Azure**.

1. In the **Deploy to Azure** dialog, select **No available webapp, click to create a new one**.

    :::image type="content" source="../media/5-deploy-to-azure-dialog.png" alt-text="Create WebApp dialog." loc-scope="other":::

1. In the **Create WebApp** dialog, fill in this information, and then select **OK**:

    | Property | Value |
    | --- | --- |
    | Name | Use the default name |
    | Subscription | *Concierge Subscription* |
    | Platform | *Linux* |
    | Web Container | *TOMCAT 8.5-jre8* |
    | Resource Group | Select **Use Existing** and select *<rgn>[sandbox resource group name]</rgn>* |
    | App Service Plan | Select **Create new** and accept the default name and location, but change the **Pricing Tier** to **Free_F1** for this exercise. |

    ![Create WebApp dialog](../media/5-create-webapp-dialog.png)

1. When the web app has been created, in the **Deploy to Azure** dialog, select **Run**. The Azure Toolkit for IntelliJ deploys the web app to Azure and displays the site in your default web browser.

    :::image type="content" source="../media/5-deployed-webapp.png" alt-text="The deployed web app running in Azure App Service." loc-scope="other":::
