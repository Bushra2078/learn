Up to this point you have only run the application on your machine. The next step is to deploy the app to Azure.

## Customize Visual Studio Code

Before you begin, there are two changes you need to make to Visual Studio Code. The first grants the Azure extension access to Learn's concierge Azure subscription. This subscription is created as you activate the sandbox and allows you to use Azure services without incurring any costs.

The second customization tells the extension to use the advanced creation process. If you skip this step, the extension uses default values and won't create your function to work with the sandbox.

### Add concierge tenant to Visual Studio Code

In the Cloud Shell, run the following command and copy the tenant ID to your clipboard.

```bash
az account list --query "[?name=='Concierge Subscription'].tenantId" -o tsv
```

1. On Windows or Linux, select **File > Preferences > Settings**. On macOS, select **Code > Preferences > Settings**.

1. Navigate through **User Settings > Extensions > Azure configuration**

1. Enter the tenant in the **Azure: Tenant** textbox.

![Add tenant ID to Visual Studio Code Azure extension configuration](../media/serverless-app-vs-code-tenant.png)

### Enable Azure Functions advanced creation

1. On Windows or Linux, select **File > Preferences > Settings**. On macOS, select **Code > Preferences > Settings**.

1. Navigate through **User Settings > Extensions > Azure Functions**

1. Check the checkbox for **Azure Function: Advanced Creation**

    ![Enable advanced Functions creation](../media/serverless-app-extension-adv-creation.png)

### Sign out and back in

Now that you've made these changes, you need to sign out and back into the Azure extension.

1. Press **F1** to open the Visual Studio Code command palette.

1. Search for and select **Azure: Sign Out**.

1. Press **F1** again.

1. Search for and select **Azure: Sign In** and sign in with the same account you used to sign into the Learn sandbox.

### Select subscription

1. Click on the Azure extension icon.

    ![Visual Studio Code Azure extension icon](../media/serverless-app-azure-extension-icon.png)

1. Under the *Functions* heading, click on **Select Subscriptions**.

    ![Visual Studio Code Azure extension: Functions section](../media/serverless-app-select-subscriptions.png)

1. Next, the command palette appears. Select **Concierge Subscription** and click **OK**.

    ![Visual Studio Code Azure extension: Select concierge subscription](../media/serverless-app-select-concierge.png)

Now Visual Studio Code is configured to use the sandbox resources and avoid any billing against your account.

## Deploy the function app

1. Press **F1** to open the Visual Studio Code command palette.

1. Search for and select the **Azure Functions: Deploy to Function App** command.

1. Follow the prompts to provide the following information.

   | Name              | Value                                                        |
   | ----------------- | ------------------------------------------------------------ |
   | Function app      | Select **Create new Function App in Azure**                  |
   | Function app name | Enter a unique name                                          |
   | OS                | Select **Windows**                                           |
   | Plan              | Select **Consumption**                                       |
   | Language          | Select **JavaScript**                                        |
   | Resource group    | Select **<rgn>[sandbox resource group name]</rgn>**          |
   | Storage account   | Select the account you created earlier                       |

    A new function app is created in Azure and the deployment begins. The Azure Functions Visual Studio Code extension first creates the Azure resources and then deploys the function app.

    Once complete, the Azure Functions extension reports the primary endpoint of the function in a message box as shown by this screenshot.

    ![New function app](../media/serverless-app-new-function-app.png)

    The functions app name (labeled as **1** in the image) is the unique name you provided as you created the app. The app end point (labeled as **2**) is the function app name followed by *azurewebsites.net*.

1. Open **public/index.html.js** and replace `<FUNCTION_APP_ENDPOINT>` with the function's endpoint.

1. Another message appears in Visual Studio code asking if you want to upload local settings. Select  **Upload settings** to copy the values from **local.settings.json** to the server.

    ![Upload local settings](../media/serverless-app-upload-local-settings.png)

    If the message box doesn't appear or was dismissed, you can still upload your local settings. Opening the command palette via **F1** and select **Azure Functions: Upload local settings**. Choose to overwrite any existing settings, if prompted.

## Configure static websites in Azure Storage

Use the following steps to configure the Azure Storage account to host a static website.

1. Open the Visual Studio Code command palette via **F1**.

1. Search for and select the **Azure Storage: Configure static website** command.

   | Name              | Value                                                             |
   | ----------------- | ----------------------------------------------------------------- |
   | Storage account   | Select the account you created earlier                            |
   | Default file      | Select **index.html** as the index document name for the account. |
   | Error document    | Press **Enter** to accept the default 404 error document path     |

## Deploy the web application to Azure Storage

1. Open the Visual Studio Code command palette via **F1**.

1. Search for and select the **Azure Storage: Deploy to Static Website** command.

1. Select the Storage account you created earlier.

1. When prompted for a folder, select **browse** and choose the *public* subfolder, which contains the web app.

1. A notification appears that the upload was successful. The upload can take several minutes.

## Determine the primary endpoint address of the static website

1. In the command palette, search for **Azure Storage: Browse static website** and choose your Storage account. The site opens in the browser. At this point, the app won't run because of CORS requirements of Azure Functions.

1. Copy the URL in the browser, which is the endpoint of the static site hosted in your Storage account. You use the endpoint value to set up CORS settings for the function app in the next section.

Keep this browser window open. You will return refresh this window once the CORS settings are updated in your function app.

## Set up CORS in the function app

1. In the command palette, search for and select the **Azure Functions: Open in portal** command.

1. Select the subscription and function app name.

1. Once the portal is open in the browser, select the **Platform features** tab and select **CORS**.

1. Check the checkbox next to **Enable Access-Control-Allow-Credentials**.

1. Add an entry with the *static website* **primary endpoint** as the value (make sure to remove the trailing `/`). You can paste this value in from your clipboard.

1. Click **Save** to persist the CORS settings.

    ![Enable CORS support for Azure Functions app](../media/serverless-app-function-cors.png)

## Run the deployed application

Now you can make change to the application's data and observe how to the data is automatically updated.

1. Arrange Visual Studio Code on one side of the screen and the web browser running the static site on the other. This way you can see the UI update as changes are made to the database.

1. In Visual Studio integrated terminal, enter the following command and watch as the UI is automatically updated.

    ```bash
    npm run update
    ```

    ![End state of serverless web app](../media/serverless-app-deployed.png)
