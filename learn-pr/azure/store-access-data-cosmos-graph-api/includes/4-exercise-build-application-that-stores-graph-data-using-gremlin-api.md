In this exercise, you'll create an Azure Cosmos DB Gremlin API account, database, and graph (container) using the Azure portal. You then build and run a console app using the open-source driver Gremlin.Net.

[!INCLUDE[](../../../includes/azure-sandbox-activate.md)]

[!INCLUDE[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

## Create a Cosmos DB account

Start by creating the database in Azure, by adding a Cosmos DB account that uses the Graph API.

1. Browse to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), and log in using the account that you used when you activated the sandbox.

1. Click **+ Create a resource**, then **Databases**, and then click **Azure Cosmos DB**.

   ![Screenshot showing creating a new Cosmos DB Account](../media/5-create-cosmos-db.png)

1. In the **Create Azure Cosmos DB Account** wizard, complete the **Basics** page with these values, and then click **Review + create**.

   | Field | Value |
   | --- | --- |
   | Subscription | Concierge Subscription |
   | Resource group | <rgn>[Sandbox resource group]</rgn> |
   | Account name | Use a globally unique value for your Cosmos DB account. |
   | API | Gremlin (graph) |
   | Location | Choose a region near you from the above list. |
   | Geo-Redundancy | Disable |
   | Multi-region Writes | Disable |

   ![Screenshot showing creating a new Cosmos DB Account](../media/5-azure-cosmos-db-create-new-account.png)

1. If your settings are correct, click **Create**.

It might take a few minutes for Azure to create your new Cosmos DB account. When you account has been created, the portal will display **Congratulations! Your Azure Cosmos DB account was created**.

## Add a graph

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), click **All resources**, and then click the Cosmos database you created.

1. On the **Overview** tab, copy the value for the **Gremlin Endpoint**; you will use this value when you create your application in the next section.

   ![Screenshot showing how to copy the Gremlin Endpoint](../media/5-copy-gremlin-endpoint.png)

1. Click **Data Explorer**, and then click **New Graph**.

1. In the **Add graph** page, enter the settings for your new graph. Take note of the values that you choose for the **Database ID** and **Graph ID**; you will use these values when you create your application in the next section.

   | Setting| Suggested value | Description |
   | --- | --- | --- |
   | **Database ID** | sample-database | Enter sample-database as the name for the new database. Database names must be between 1 and 255 characters, and cannot contain / \ # ? or a trailing space. |
   | **Graph ID** | sample-graph | Enter sample-graph as the name for your new collection. Graph names have the same character requirements as database IDs. |
   | **Storage Capacity** | Fixed (10 GB) | Specify a fixed value of 10 GB. This value is the storage capacity of the database |
   | **Throughput** | 400 RUs | Change the throughput to 400 request units per second (RU/s). If you want to reduce latency, you can scale up the throughput later. |

   ![Screenshot showing creating a new Graph](../media/5-azure-cosmosdb-data-explorer-graph.png)

1. Click **OK** to add the graph to your database.

1. Click **Keys**, then copy the value for the **PRIMARY KEY**; you will use this value when you create your application in the next section.

   ![Screenshot showing how to copy the access key](../media/5-copy-gremlin-key.png)

## Create a .NET Core app

Now you'll create a .NET Core application that will allow you to run Gremlin API queries with the Cosmos DB account that you just created.

1. In the Cloud Shell, enter the following commands to scaffold a new .NET app, and then change to your new app's directory.

   ```bash
   dotnet new console -n GremlinApp
   cd GremlinApp
   ```

1. Add the necessary packages to your app for Gremlin.net and Microsoft.Extensions.Configuration.

   ```bash
   dotnet add package Gremlin.net
   dotnet add package Microsoft.Extensions.Configuration
   dotnet add package Microsoft.Extensions.Configuration.FileExtensions
   dotnet add package Microsoft.Extensions.Configuration.Json
   dotnet restore
   ```

1. Create a file for your application settings.

   ```bash
   touch appsettings.json
   ```

1. Open your app in the online code editor.

   ```bash
   code .
   ```

1. Open your appsettings.json file in the editor, and add the following syntax.

   ```json
   {
     "AzureConfig": {
      "HostName" : "endpoint.gremlin.cosmos.azure.com",
      "Port" : "443",
      "AuthKey" : "AbCdEfGhIjKlMnOpQrStUvWxYz==",
      "Database" : "sample-database",
      "Collection" : "sample-graph"
      }
   }
   ```

   Where:

   | Field | Description |
   |---|---|
   | `HostName` | Replace this with just the domain name from the **Gremlin Endpoint** value; for example *fabrikamgraph.gremlin.cosmos.azure.com*. |
   | `Port` | Replace this with just the port from the **Gremlin Endpoint** value; this should be *443*. |
   | `AuthKey` | Replace this with the **PRIMARY KEY** value. |
   | `Database` | Replace this with your **Database ID** value; for example: *sample-database*. |
   | `Collection` | Replace this with your **Graph ID** value; for example: *sample-graph*. |

1. To save your changes, press **Ctrl-S** to save the file.

1. Open your Program.cs file in the editor, and add the following `using` statements to the beginning of the file.

   ```csharp
   using System;
   using System.Threading.Tasks;
   using Gremlin.Net.Driver;
   using Gremlin.Net.Driver.Exceptions;
   using Gremlin.Net.Structure.IO.GraphSON;
   using Microsoft.Extensions.Configuration;
   using Microsoft.Extensions.Configuration.FileExtensions;
   using Microsoft.Extensions.Configuration.Json;
   ```

1. Replace the default `Main()` method with the following code. This method reads your configuration settings from your appsettings.json file, initializes the connection to your Cosmos DB account using the Gremlin.NET driver, sends a graph query to the server, and displays the number of items that were returned by the query.


   ```csharp
   static void Main(string[] args)
   {
      try
      {
         if (args.Length!=1)
         {
            Console.WriteLine("Please enter a Gremlin/Graph Query.");
         }
         else
         {
            var azureConfig = new ConfigurationBuilder()
               .SetBasePath(Environment.CurrentDirectory)
               .AddJsonFile("appsettings.json", optional: false, reloadOnChange: false)
               .Build()
               .GetSection("AzureConfig");
            var hostname = azureConfig["HostName"];
            var port = Convert.ToInt32(azureConfig["Port"]);
            var authKey = azureConfig["AuthKey"];
            var database = azureConfig["Database"];
            var collection = azureConfig["Collection"];
            var gremlinServer = new GremlinServer(
               hostname, port, enableSsl: true,
               username: $"/dbs/" + database + "/colls/" + collection,
               password: authKey);
            using (var gremlinClient = new GremlinClient(gremlinServer, new GraphSON2Reader(), new GraphSON2Writer(), GremlinClient.GraphSON2MimeType))
            {
               var resultSet = AzureAsync(gremlinClient, args[0]);
               Console.WriteLine("\n{{\"Returned\": \"{0}\"}}", resultSet.Result.Count);
            }
         }
      }
      catch (Exception ex)
      {
         Console.WriteLine("EXCEPTION: {0}", ex.Message);
      }
   }
   ```

1. Add a new `AzureAsync()` method after `Main()` method with the following code. This method will execute the query and return a result set that the `Main()` method will use to determine the number of nodes that were returned by the query.

   ```csharp
   private static Task<ResultSet<dynamic>> AzureAsync(GremlinClient gremlinClient, string query)
   {
      try
      {
         return gremlinClient.SubmitAsync<dynamic>(query);
      }
      catch (ResponseException ex)
      {
         Console.WriteLine("EXCEPTION: {0}", ex.StatusCode);
         throw;
      }
   }
   ```

1. To save your changes, press **Ctrl-S** to save the file, and then press **Ctrl-Q** to exit the editor.

## Run queries with your .NET Core app

1. From the Command Shell, run the following command:

   ```bash
   dotnet run
   ```
   Your app should display a simple help message; for example:
   ```
   Please enter a Gremlin/Graph Query.
   ```

1. Your new Cosmos DB account should not contain any data, but just to make sure, run the following command to remove all of the nodes:

   ```bash
   dotnet run "g.V().drop()"
   ```
   Your app should display a message indicating that no nodes were returned; for example:
   ```json
   {"Returned": "0"}
   ```

1. Now you'll add some product nodes to your database. To do so, run the following commands:

   ```bash
   dotnet run "g.addV('Product').property('id', 'p1').property('name', 'Phone Charger').property('price', 12.99)"
   dotnet run "g.addV('Product').property('id', 'p2').property('name', 'USB C Cable Charger').property('price', 8.99)"
   dotnet run "g.addV('Product').property('id', 'p3').property('name', 'Gardening Gloves').property('price', 2.99)"
   ```
   Your app should display a message for each command indicating that 1 vertice/node was returned; for example:
   ```json
   {"Returned": "1"}
   ```

1. Now add some category nodes to your database. To do so, run the following commands:

   ```bash
   dotnet run "g.addV('Category').property('id', 'c1').property('name', 'Mobile Phones')"
   dotnet run "g.addV('Category').property('id', 'c2').property('name', 'Gardening')"
   ```
   Your app should display a message for each command indicating that 1 vertice/node was returned:
   ```json
   {"Returned": "1"}
   ```

1. Verify that all of your vertices/nodes have been added to your database. To do so, run the following command:

   ```bash
   dotnet run "g.V()"
   ```
   Your app should display a message indicating that 5 vertices/nodes were returned; for example:
   ```json
   {"Returned": "5"}
   ```

1. Now add some product to category relationships to your database. To do so, run the following commands:

   ```bash
   dotnet run "g.V('p1').addE('belongsto').to(g.V('c1'))"
   dotnet run "g.V('p2').addE('belongsto').to(g.V('c1'))"
   dotnet run "g.V('p3').addE('belongsto').to(g.V('c2'))"
   ```
   Your app should display a message for each command indicating that 1 edge/relationship was returned; for example:
   ```json
   {"Returned": "1"}
   ```

1. Verify that all of your edges/relationships have been added to your database. To do so, run the following command.

   ```bash
   dotnet run "g.E()"
   ```
   Your app should display a message indicating that 3 edges/relationships were returned; for example.
   ```json
   {"Returned": "3"}
   ```

## Examine your data in the Azure portal

You can now use the Data Explorer in the Azure portal to browse and query your new graph data.

1. In Data Explorer, expand the database and container nodes, and then click **Graph**.

1. Click the **Execute Gremlin Query** button to use the default query to view all the vertices in the graph.

    ![Screenshot showing the data model of the products added and their relationships to other vertices](../media/5-cosmos-db-data-explorer.png)

The data you entered using the .NET Core app is displayed in the Graph pane. You can zoom in and out of the graph, you can expand the graph display, add additional vertices, and move vertices on the display surface.