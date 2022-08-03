Recall that you can create items within your container using the Azure Cosmos DB SDK for .NET. For this project, the products container will contain both the individual *product* items and special *category* items for each category. There's two cases you want to handle in this application:

- If a category is empty, it's fine to just create that category's item individually. There are no related product items to create.
- However, if a category has related products, you'll want to create the category item and the related product items simultaneously.

Right now, you have two key requirements:

01. Create an item individually as a single operation
01. Use a transactional batch to create multiple related items

:::image type="content" source="../media/project-visual-upload.png" alt-text="Illustration of icons indicating data being uploaded to the cloud." lightbox="../media/project-visual-upload.png" border="false":::

After you complete this exercise, your project will have the logic to create items in your container either individually, or as a batch.

## Reinitialize your environment (optional)

It's possible, if you closed your Azure Cloud Shell terminal pane, for the terminal instance to no longer have access to the environment variable and code editor. Here, if needed, you'll set your environment variable again and open the code editor.

> [!NOTE]
> You can safely skip this section if your terminal is already open, your environment variable is still set, and you are already editing your project in the code editor.

01. Set the environment variable named `COSMOS_CONNECTION_STRING` to the value of this command, which gets a connection string to the first Azure Cosmos DB SQL API account in your sandbox subscription.

    ```azurecli
    export COSMOS_CONNECTION_STRING=$(az cosmosdb keys list \
        --name $(az cosmosdb list \
            --resource-group <rgn>[sandbox resource group name]</rgn> \
            --query [0].name \
            --output tsv) \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --type connection-strings \
        --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" \
        --output tsv)
    ```

01. Change to the *clouddrive/inventory* directory and open a code editor.

    ```bash
    cd ~/clouddrive/inventory && code .
    ```

## Add an individual item to a container

In Azure Cosmos DB, you can create, replace, or upsert items to a container. Creating an item requires that the item has a unique identifier. Replacing an item requires that the item already exists. Upsert is the best of both worlds where it will check the unique identifier, and then replace or create the item. For this project, you want to be able to run the app multiple times without errors making *upsert* a clear choice. For our first item, we'll create a category that doesn't have any associated products. Here, you'll implement a single upsert operation with a manually created category.

01. Open the *Program.cs* file again.

01. Create a new **Category** instance named `helmets` with the following values:

    | Property | Value |
    | --- | --- |
    | **id** | `91f79374-8611-4505-9c28-3bbbf1aa7df7` |
    | **categoryId** | `gear-climb-helmets` |

    ```csharp
    Category helmets = new(
        Id: "91f79374-8611-4505-9c28-3bbbf1aa7df7",
        CategoryId: "gear-climb-helmets"
    );
    ```

01. Create a new <xref:Microsoft.Azure.Cosmos.PartitionKey?displayProperty=nameWithType> instance using the same value as the `categoryId` property for the **Category** instance you created earlier.

    ```csharp
    PartitionKey helmetsKey = new("gear-climb-helmets");
    ```

01. Use the <xref:Microsoft.Azure.Cosmos.Container.UpsertItemAsync%2A?displayProperty=nameWithType> method to create or replace the item passing in an object for the item to create and a partition key value.

    ```csharp
    ItemResponse<Category> response = await container.UpsertItemAsync(helmets, helmetsKey);
    ```

01. Print various properties of the response object to the console including: The unique identifier of the item, the type of the item, and the request charge in RUs.

    ```csharp
    Console.WriteLine($"[New item created]:\t{response.Resource.id}\t(Type: {response.Resource.type})\t(RUs: {response.RequestCharge})");
    ```

01. **Save** the *Program.cs* file.

## Implement multiple operations as a transactional batch

Now consider a scenario where you want to create multiple products along with a category. If the products are created, but the category doesn't exist, those products aren't nearly as useful. Creating multiple items is a situation where you can use a transaction to group multiple "point" operations together so they all succeed or fail as a single cohesive unit. Going back to our scenario, we need to create a category for outdoor tents with a few tent products. We already have a single category item without any product items. Here's what we should end up with:

:::image type="content" source="../media/diagram-items.png" alt-text="Diagram of various items in Azure Cosmos DB organized by their specific partition key. The diagram illustrates how five items belong to the \"tents\" partition key value and only one item belongs to \"helmets\"." lightbox="../media/diagram-items.png" border="false":::

In this section, we'll create a transactional batch to create the `tents` category and related products together.

01. Create a new **Category** instance named `tents` with the following values:

    | Property | Value |
    | --- | --- |
    | **id** | `5df21ec5-813c-423e-9ee9-1a2aaead0be4` |
    | **categoryId** | `gear-camp-tents` |

    ```csharp
    Category tents = new(
        id: "5df21ec5-813c-423e-9ee9-1a2aaead0be4",
        categoryId: "gear-camp-tents"
    );
    ```

01. Create four instances of the **Product** type using these values.

    | Property | `cirroa` | `kuloar` | `mammatin` | `nimbolo` |
    | --- | --- | --- | --- | --- |
    | **id** | `e8dddee4-9f43-4d15-9b08-0d7f36adcac8` | `e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa` | `f7653468-c4b8-47c9-97ff-451ee55f4fd5` | `6e3b7275-57d4-4418-914d-14d1baca0979` |
    | **categoryId** | `gear-camp-tents` | `gear-camp-tents` | `gear-camp-tents` | `gear-camp-tents` |
    | **name** | `Cirroa Tent` | `Kuloar Tent` | `Mammatin Tent` | `Nimbolo Tent` |
    | **price** | `490.00` | `530.00` | `0.00` | `330.00` |
    | **archived** | `false` | `false` | `true` | `false` |
    | **quantity** | `15` | `8` | `0` | `35` |

    ```csharp
    Product cirroa = new(
        id: "e8dddee4-9f43-4d15-9b08-0d7f36adcac8",
        categoryId: "gear-camp-tents",
        name: "Cirroa Tent", 
        price: 490.00m, 
        archived: false, 
        quantity: 15
    );
    
    Product kuloar = new(
        id: "e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa",
        categoryId: "gear-camp-tents",
        name: "Kuloar Tent", 
        price: 530.00m, 
        archived: false, 
        quantity: 8
    );
    
    Product mammatin = new(
        id: "f7653468-c4b8-47c9-97ff-451ee55f4fd5",
        categoryId: "gear-camp-tents",
        name: "Mammatin Tent", 
        price: 0.00m, 
        archived: true, 
        quantity: 0
    );
    
    Product nimbolo = new(
        id: "6e3b7275-57d4-4418-914d-14d1baca0979",
        categoryId: "gear-camp-tents",
        name: "Nimbolo Tent", 
        price: 330.00m, 
        archived: false, 
        quantity: 35
    );
    ```

01. Now, create a new <xref:Microsoft.Azure.Cosmos.PartitionKey?displayProperty=fullName> instance using the `gear-camp-tents` value.

    ```csharp
    PartitionKey tentsKey = new("gear-camp-tents");
    ```

01. Create a new transactional batch scoped to the `gear-camp-tents` partition key value using the <xref:Microsoft.Azure.Cosmos.Container.CreateTransactionalBatch?displayProperty=nameWithType> method. Using the fluent syntax, add five *upsert* operations to create the items we need in our container for the category and all of the related products.

    ```csharp
    TransactionalBatch batch = container.CreateTransactionalBatch(tentsKey)
        .UpsertItem<Category>(tents)
        .UpsertItem<Product>(cirroa)
        .UpsertItem<Product>(kuloar)
        .UpsertItem<Product>(mammatin)
        .UpsertItem<Product>(nimbolo);
    ```

01. Output a message to the console to indicating that we're starting a batch operation.

    ```csharp
    Console.WriteLine("[Batch started]");
    ```

01. Use the `TransactionalBatch.ExecuteAsync` method to execute the batch and return a special response type.

    ```csharp
    using TransactionalBatchResponse batchResponse = await batch.ExecuteAsync();
    ```

01. Using a for loop, iterate through all of the items in the response. First, convert each item to the type `TransactionalBatchOperationResult` using your `Item` base class as the generic. Then, print the unique identifier and type of the response object.

    ```csharp
    for (int i = 0; i < batchResponse.Count; i++)
    {
        TransactionalBatchOperationResult<Item> result = batchResponse.GetOperationResultAtIndex<Item>(i);
        Console.WriteLine($"[New item created]:\t{result.Resource.id}\t(Type: {result.Resource.type})");
    }
    ```

01. Output another message to the console indicating that the batch is complete. Include the request charge for the entire batch in this message.

    ```csharp
    Console.WriteLine($"[Batch completed]:\t(RUs: {batchResponse.RequestCharge})");
    ```

01. **Save** the *Program.cs* file.

## Check your work

Your app now creates multiple items and is designed to be resilient enough to be ran multiple times without causing an exception. Here, you'll run the application and check the output for the unique identifiers of each of the six newly created items.

### [Run application](#tab/run-app)

01. Run the .NET application in the terminal

    ```dotnetcli
    dotnet run
    ```  

01. Observe the output of running the application. The output should match the example here.

    ```output
    ...
    [New item created]:     91f79374-8611-4505-9c28-3bbbf1aa7df7    (Type: Category)        (RUs: 10.29)
    [Batch started]
    [New item created]:     5df21ec5-813c-423e-9ee9-1a2aaead0be4    (Type: Category)
    [New item created]:     e8dddee4-9f43-4d15-9b08-0d7f36adcac8    (Type: Product)
    [New item created]:     e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa    (Type: Product)
    [New item created]:     f7653468-c4b8-47c9-97ff-451ee55f4fd5    (Type: Product)
    [New item created]:     6e3b7275-57d4-4418-914d-14d1baca0979    (Type: Product)
    [Batch completed]:      (RUs: 48.76)
    ```

    > [!TIP]
    > The RUs shown in this example output may vary from your output.

### [Review code](#tab/review-code)

01. Review the *Item.cs* code file to make sure that your code matches this sample.

    ```csharp
    public record Item(
        string Id,
        string CategoryId,
        string Type
    );
    ```

01. Review the *Category.cs* code file to make sure that your code matches this sample.

    ```csharp
    public record Category(
       string Id,
        string CategoryId
    ) : Item(
        Id,
        CategoryId,
        nameof(Category)
    );
    ```

01. Review the *Product.cs* code file to make sure that your code matches this sample.

    ```csharp
    public record Product(
        string Id, 
        string CategoryId, 
        string Name, 
        decimal Price, 
        bool Archived, 
        int Quantity
    ) : Item(
        Id,
        CategoryId,
        nameof(Product)
    );
    ```

01. Review the *Program.cs* code file to make sure that your code matches this sample.

    ```csharp
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Fluent;
    
    string connectionString = Environment.GetEnvironmentVariable("COSMOS_CONNECTION_STRING")!;
    
    Console.WriteLine($"[Connection string]:\t{connectionString}");
    
    CosmosSerializationOptions serializerOptions = new()
    {
        PropertyNamingPolicy = CosmosPropertyNamingPolicy.CamelCase
    };
    
    using CosmosClient client = new CosmosClientBuilder(connectionString)
        .WithSerializerOptions(serializerOptions)
        .Build();
    
    Console.WriteLine("[Client connected]");

    Database database = await client.CreateDatabaseIfNotExistsAsync(
        id: "cosmicworks"
    );
    
    Console.WriteLine($"[Database created]:\t{database.Id}");
    
    Container container = await database.CreateContainerIfNotExistsAsync(
        id: "products",
        partitionKeyPath: "/categoryId",
        throughput: 400
    );
    
    Console.WriteLine($"[Container created]:\t{container.Id}");

    Category helmets = new(
        Id: "91f79374-8611-4505-9c28-3bbbf1aa7df7",
        CategoryId: "gear-climb-helmets"
    );
    
    PartitionKey helmetsKey = new("gear-climb-helmets");
    
    ItemResponse<Category> response = await container.UpsertItemAsync(helmets, helmetsKey);
    
    Console.WriteLine($"[New item created]:\t{response.Resource.Id}\t(Type: {response.Resource.Type})\t(RUs: {response.RequestCharge})");
    
    Category tents = new(
        Id: "5df21ec5-813c-423e-9ee9-1a2aaead0be4",
        CategoryId: "gear-camp-tents"
    );
    
    Product cirroa = new(
        Id: "e8dddee4-9f43-4d15-9b08-0d7f36adcac8",
        CategoryId: "gear-camp-tents",
        Name: "Cirroa Tent", 
        Price: 490.00m, 
        Archived: false, 
        Quantity: 15
    );
    
    Product kuloar = new(
        Id: "e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa",
        CategoryId: "gear-camp-tents",
        Name: "Kuloar Tent", 
        Price: 530.00m, 
        Archived: false, 
        Quantity: 8
    );
    
    Product mammatin = new(
        Id: "f7653468-c4b8-47c9-97ff-451ee55f4fd5",
        CategoryId: "gear-camp-tents",
        Name: "Mammatin Tent", 
        Price: 0.00m, 
        Archived: true, 
        Quantity: 0
    );
    
    Product nimbolo = new(
        Id: "6e3b7275-57d4-4418-914d-14d1baca0979",
        CategoryId: "gear-camp-tents",
        Name: "Nimbolo Tent", 
        Price: 330.00m, 
        Archived: false, 
        Quantity: 35
    );
    
    PartitionKey tentsKey = new("gear-camp-tents");
    
    TransactionalBatch batch = container.CreateTransactionalBatch(tentsKey)
        .UpsertItem<Category>(tents)
        .UpsertItem<Product>(cirroa)
        .UpsertItem<Product>(kuloar)
        .UpsertItem<Product>(mammatin)
        .UpsertItem<Product>(nimbolo);
    
    Console.WriteLine("[Batch started]");
    
    using TransactionalBatchResponse batchResponse = await batch.ExecuteAsync();
    
    for (int i = 0; i < batchResponse.Count; i++)
    {
        TransactionalBatchOperationResult<Item> result = batchResponse.GetOperationResultAtIndex<Item>(i);
        Console.WriteLine($"[New item created]:\t{result.Resource.Id}\t(Type: {result.Resource.Type})");
    }
    
    Console.WriteLine($"[Batch completed]:\t(RUs: {batchResponse.RequestCharge})");
    ```

---
