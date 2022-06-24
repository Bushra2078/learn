You want to explore how to create an Azure Cognitive Search index and upload documents to that index using C# code.

In this exercise, you'll clone an existing C# solution and run it to work out the optimal batch size to upload documents. You'll then use this batch size and upload documents effectively using a threaded approach.

> [!NOTE]
>To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free?azure-portal=true).

## Set up your development environment

Install these tools to complete this exercise. You can still follow along with the steps without these tools.

1. Install [VS Code](https://code.visualstudio.com/)
1. Install [.NET Core 3.1](https://dotnet.microsoft.com/en-us/download/dotnet/3.1).

### Set up your Azure resources

To save you time, select this Azure ARM template to create resources you'll need later in the exercise.

1. <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftLearning%2Fmslearn-doc-intelligence%2Fmain%2Fcognitive-search%2Fazuredeploy.json" rel="nofollow"><img src="../media/deploytoazure.svg" alt="Deploy to Azure" data-canonical-src="https://aka.ms/deploytoazurebutton"></a> select this link to create an Azure Cognitive Search service.
    :::image type="content" source="../media/deploy-azure-resources.png" alt-text="A screenshot of the options shown when deploying resources to Azure.":::

1. In **Resource group**, select **Create new**, name it **cog-search-language-exe**.
1. In **Region**, select a [supported region](/azure/cognitive-services/language-service/custom-text-classification/service-limits#regional-availability) that is close to you.
1. The **Resource Prefix** needs to be globally unique, enter a random numeric and lower-case character prefix, for example, **acs18245**.
1. In **Location**, select the same region you chose above.
1. Select **Review + create**.
1. Select **Create**.

    > [!NOTE]
    > There's an error shown, **You will need to Agree to the terms of service below to create this resource successfully.**, by selecting **Create** you are agreeing to them.
    
1. Select **Go to resource group** to see all the resources that you've created.

    :::image type="content" source="../media/azure-resources-created.png" alt-text="A screenshot of the deployed resources." lightbox="../media/azure-resources-created.png":::

### Copy Azure Cognitive Search service REST API information

1. In the list of resources, select the search service you created. In the above example **acs18245-search-service**.
1. Copy the search service name into a text file.

    :::image type="content" source="../media/search-api-keys.png" alt-text="A screenshot of the keys section of a search service.":::

1. On the left, select **Keys**, then copy the **Primary admin key** into the same text file.

### Download example code

In your development environment, clone this example code repository.

```powershell
git clone https://github.com/Azure-Samples/azure-search-dotnet-samples samples
```

In your file explorer, open the optimize-data-indexing/v11 folder in VS Code. For example, the full path might be `C:\samples\optimize-data-indexing\v11`.

:::image type="content" source="../media/open-example-solution.png" alt-text="A screenshot showing the file explorer opening the sample code directory in VS Code.":::

This action will open the V11 folder in VS Code.

:::image type="content" source="../media/setup-visual-studio-code-solution.png" alt-text="A screenshot of VS Code showing the set up notifications.":::

1. In VS Code, in the notifications, select **Yes**, and then select **Restore**.

    VS Code will download the correct version of the `Azure.Search.Document` client library.
    
    :::image type="content" source="../media/update-app-settings.png" alt-text="A screenshot showing the contents of the appsettings.json file.":::

1. In the navigation on the left, expand the **OptimizeDataIndexing** folder, then select the **appsettings.json** file.
1. Paste in your search service name and primary admin key.

    ```json
    {
      "SearchServiceUri": "https://acs18245-search-service.search.windows.net",
      "SearchServiceAdminApiKey": "i0eU0C4aOZxlC9jNPnA87pjRVTeWyT8ehnEtvQPQIgAzSeAAGnHH",
      "SearchIndexName": "optimize-indexing"
    }
    ```

    The settings file should look similar to the above.
1. Run the app without debugging, press <kbd>CTRL</kbd>+<kbd>F5</kbd>.

    :::image type="content" source="../media/debug-application.png" alt-text="A screenshot showing the app running in VS Code with an exception.":::

    The app runs and will end with an exception because it's not running in a console.

The output shows that in this case, the best performing batch size is 1000 documents. As it reaches 1.71 MB per second.

### Edit the code to implement threading and a backoff and retry strategy

There's code commented out that's ready to change the app to use threads to upload documents to the search index.

1. In VS Code on the left, select **Explore**, then select **Program.cs**.

    :::image type="content" source="../media/edit-program-code.png" alt-text="A screenshot of VS Code showing the Program.cs file.":::

1. Comment out lines 38 and 39.

    ```csharp
    //Console.WriteLine("{0}", "Finding optimal batch size...\n");
    //await TestBatchSizesAsync(searchClient, numTries: 3);
    ```

1. Uncomment lines 41 to 49.

    ```csharp
    long numDocuments = 100000;
    DataGenerator dg = new DataGenerator();
    List<Hotel> hotels = dg.GetHotels(numDocuments, "large");

    Console.WriteLine("{0}", "Uploading using exponential backoff...\n");
    await ExponentialBackoff.IndexDataAsync(searchClient, hotels, 1000, 8);

    Console.WriteLine("{0}", "Validating all data was indexed...\n");
    await ValidateIndexAsync(indexClient, indexName, numDocuments);
    ```

    The code that controls the batch size and number of threads is `await ExponentialBackoff.IndexDataAsync(searchClient, hotels, 1000, 8)`. The batch size is 1000 and the threads are eight.

    :::image type="content" source="../media/thread-code-ready.png" alt-text="A screenshot showing all the edited code.":::

    Your code should look like the above.

1. Save your changes, press <kbd>CTRL</kbd>+<kbd>S</kbd>.
1. Run the app without debugging, press <kbd>CTRL</kbd>+<kbd>F5</kbd>.

    :::image type="content" source="../media/upload-hundred-thousand-documents.png" alt-text="A screenshot showing the completed messages in the console.":::

    The app will start eight threads, and then as each thread finishes writing a new message to the console:

    ```powershell
    Finished a thread, kicking off another...
    Sending a batch of 1000 docs starting with doc 57000...
    ```

    After uploading 100,000 documents, the app writes a summary:

    ```powershell
    Ended at: 6/17/2022 14:49:15 

    Upload time total: 00:01:35.5200306
    Upload time per batch: 955.2003 ms
    Upload time per document: 0.9552 ms 
    
    Validating all data was indexed...
    
    Waiting for document count to update...
    
    Document Count is 100000

    Waiting for service statistics to update...
    
    Index Statistics: Document Count is 100000
    Index Statistics: Storage Size is 69157943
    ```

Explore the code in the `TestBatchSizesAsync` procedure to see how the code tests the batch size performance.

Explore the code in the `IndexDataAsync` procedure to see how the code manages threading.

Explore the code in the `ExponentialBackoffAsync` to see how the code implements an exponential backoff retry strategy.

You can search and verify that the documents have been added to the index in the Azure portal.

:::image type="content" source="../media/check-search-service-index.png" alt-text="A screenshot showing the search index with 100000 documents.":::

### Delete exercise resources

Now that you've completed the exercise, delete all the resources you no longer need. Start with the code cloned to your machine. Then delete the Azure resources.

1. In the Azure portal, select **All resources**.
1. Select the resources you don't need, then select **Delete**.
