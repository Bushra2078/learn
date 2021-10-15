To present Azure Functions to users as parts of a single API, you can add them to Azure API Management.

In your online store company, your developers have created multiple Azure Functions as microservices. Each function implements a small part of the store's functionality. You want to assemble these functions into single API.

In this exercise, you will create a new API Management instance and then add a Product Details function to it.

## Create functions

In the following steps, you will add an Azure Function app to Azure API Management. Later, you will add a second function app to the same API Management instance to create a single serverless API from multiple functions. Let's start by using a script to create the functions:

1. To clone the functions project, run the following command in Azure Cloud Shell on the right.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-apim-and-functions.git ~/OnlineStoreFuncs
    ```

1. Run the following commands in Cloud Shell to set up the necessary Azure resources we need for this exercise.

    ```bash
    cd ~/OnlineStoreFuncs
    bash setup.sh
    ```

    The `setup.sh` script creates the two function apps in the sandbox resource group that we've activated for this module. As the following graphic illustrates, each app hosts a single function - `OrderDetails` and `ProductDetails`. The script also sets up a storage account for  the functions. The functions both have URLs in the **azurewebsites.net** domain. The function names include random numbers for uniqueness. The script takes a few minutes to complete.

    :::image type="content" source="../media/3-script-results.png" alt-text="Diagram illustrating the results of the setup.sh script and how the functions relate to the overall application's design." border="false":::

## Test the product details function

Now, let's test the ProductDetails function to see how it behaves before we add it to API Management.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account that you used to activate the sandbox.

1. On the Azure portal menu or from the **Home** page, select **All resources**. The **All resources** pane appears.

1. Select the Function App whose name begins with **ProductFunction**. The Function App pane appears.

1. In the Function App menu, under **Functions**, select **Functions**. The **Functions** pane appears for your Function App.

    :::image type="content" source="../media/3-select-function.png" alt-text="Screenshot of menu selections to open ProductDetails function.":::

1. From the list of functions for your function app, select **ProductDetails**. The **ProductDetails** Function pane appears.
  
1. In the Product Details menu, under **Developer**, select **Code + Test**. The **Code + Test** pane for the ProductDetails function appears, showing the contents of `function.json` file.

    :::image type="content" source="../media/3-code-test-product-details-function.png" alt-text="Screenshot of the ProductDetails Code and Test pane, with Test/Run selected in the command bar.":::

1. On the command bar, select **Test/Run**.  The Input/Output pane appears for testing your HTTP request.

1. On the **Input** tab, in the **HTTP method** field dropdown list, select **GET**, and then under **Query**, in the **Name** field, enter *id*, and in the **Value** field, enter *3*, and then select **Run**. If there are no input fields under query, select **Add parameter** and then complete this step.

    :::image type="content" source="../media/3-test-input.png" alt-text="Screenshot of the input pane for Test + Run, with the input parameter for the HTTP GET method highlighted.":::

1. A log pane appears to connect the request. The **Output** tab displays the HTTP response code (200 OK) and content for item 3 in the database.

    :::image type="content" source="../media/3-test-output.png" alt-text="Screenshot of the output of a pane for Test + Run with response results of running the GET method.":::

    Optionally, you can also test the function by inputting ID values 1 and 2.

1. Select **Close** to close the Input Output tabs for Code + Test.

1. On the command bar of the ProductDetails Code + Test pane, select **Get function URL**. Notice that the URL subdomain is the name of your function app, followed by the  **azurewebsites.net** domain. Copy and save the URL for later in this exercise.

> [!NOTE]
> You can use this URL to test the function in your browser. The URL requires an input; append the query string `&id=1` to request details about the first item in your product collection.

## Expose function app as an API using Azure API Management

After the function app has been deployed and tested, let's export it as an API using Azure API Management so that it can be called from other apps and services.

1. In the resource menu, select **All resources**. The **All resources** pane appears.

1. Sort the list of resources by type. Notice you have an OrderFunction app and a ProductFunction app.
 
1. Select the **ProductFunction** function app.

1. In the Function App menu, scroll to **API** category, and then select **API Management**. The **API Management** pane for ProductFunction function app appears.

    :::image type="content" source="../media/3-create-api.png" alt-text="Screenshot showing menu selection to open the API Management app service.":::
 
1. Under the **API Management** field, select **Create new**. The **API Management service** pane appears.

    :::image type="content" source="../media/3-api-details.png" alt-text="Screenshot showing settings for an API Management service.":::
    
1. Enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | Name | The default value ProductFunctionnnnnnnnnnn-apim should be OK. The name must be unique within the **azure-api.net** domain |
    | Subscription | Concierge Subscription |
    | Resource group | <rgn>[sandbox resource group name]</rgn> |
    | Location | Choose a location that supports the Consumption Plan: **(US) West US**, **North Central US**, **West Europe**, **North Europe**, **Southeast Asia**, **Australia East**  | 
    | Organization name | OnlineStore |
    | Administrator email | Accept the default value |
    | Pricing tier | Consumption 

1. Select **Export** to provision a linked API Management instance. Allow several minutes for the export to complete.

1. When the API Management instance has been completed, select **Link API**.

    :::image type="content" source="../media/3-link-api.png" alt-text="Screenshot of API Management highlighting the Link API button.":::

    The **Import Azure Functions** API Management service pane appears with the **ProductDetails** function highlighted.

    :::image type="content" source="../media/3-import-azure-functions.png" alt-text="Screenshot showing the Import Azure Functions API Management service pane.":::

1. Select **Select** to continue. The **Create from Function App** dialog box appears.

    :::image type="content" source="../media/3-create-from-function-app.png" alt-text="Screenshot showing the Create from Function app dialog box.":::

1. Change the **API URL suffix** value to *products*, and then select **Create**. Azure creates the API for the **ProductDetails** function. The Design tab for **API Management** pane for your function app appears.

This exercise shows that you were able to define your API, all from within the Azure Function App service.

## Test the OnlineStore products endpoint

You now have a functional product details API in the API Management instance that you created. Let's test that API with the API Management tools in Azure.

1. In the **API Management** pane, select the **Test** tab from the command bar. The available operations for your API appear in the left column.

1. In the left column, select **GET ProductDetails** operation. The ProductDetails Console appears in the right pane.

1. Under **Query parameters**, select **Add parameter**.

    :::image type="content" source="../media/3-complete-product-details-test.png" alt-text="Screenshot showing ProductDetails Console with query parameter values highlighted for the GET HTTP request.":::

1. In the **NAME** field, enter *id*, and in the **VALUE** field, enter *1*, and then select **Send** to generate a GET request.

    The **HTTP response** section of the console has two tabs, Message and Trace. The Message tab is populated with HTTP response. The product details appear in JSON format at the end of the response. Scroll up to the **HTTP request** section and notice the format of the request. The request was sent to a destination in the **azure-api.net** domain. This location is different from the **azurewebsites.net** domain where the function app is hosted. You can test this API with other query parameters, such as *id=2* or *id=3*.

   :::image type="content" source="../media/3-api-http-response.png" alt-text="Screenshot showing the **Http request** and **HTTP response** message.":::
