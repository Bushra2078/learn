In this exercise, you create the tables to start Woodgrove Bank's developers on building a distributed version of Woodgrove Bank payment app's database:

![Diagram of the relationships between users, events, merchants, and event types. payment_events' event_type field is now event_type_id, with a foreign key relationship to a new table named event_types. The event_types table contains the name and event_type_id, with the event_type_id as its primary key. The payment_events table also has a foreign key relationship to a new table named payment_merchants. The payment_merchants table has merchant_id, name, and url. The merchant_id is the primary key for payment_merchants.](../media/normalized-database-erd.png)

## Create an Azure Cosmos DB for PostgreSQL database

Create an Azure Cosmos DB for PostgreSQL database with the following specifications:

* One coordinator node, with 4 vCores and 0.5 TiB of storage
* Two worker nodes, each with 4 vCores and 0.5 TiB of storage

1. Open a web browser and navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com).

2. Next, select **Create a resource**, **Databases**, and **Azure Cosmos DB**. You can also use the **Search** functionality to find the resource.

    ![Screenshot of Create an Azure Cosmos DB for PostgreSQL resource. Databases in the Categories navigation and Azure Cosmos DB in the Popular Azure services section are highlighted.](../media/cosmos-db-for-postgresql-create.png)

3. On the **Select API option** screen, select **Create** within the **PostgreSQL** tile.

    ![Screenshot of the Azure Cosmos DB API options. The PostgreSQL option is highlighted.](../media/cosmos-db-select-api-option.png)

    > The portal will display an Azure Cosmos DB for PostgreSQL configuration screen.

4. On the **Basics** tab, enter the following information:

    | Parameter       | Value |
    | --------------- | ----- |
    | **Project details** |       |
    | Subscription    | Leave as the default subscription for the sandbox environment.  |
    | Resource group  | Select **Create new** and name your resource group `learn-cosmosdb-postgresql`. |
    | **Cluster details** |       |
    | Cluster name    | _Enter a globally unique name_, such as `learn-cosmosdb-postgresql`. |
    | Location        | Leave the default, or use a region that is close to you. |
    | Scale           | See configuration settings in the next step. |
    | PostgreSQL version | Leave the default version (14) selected. |
    | **Administrator account** | |
    | Admin username  | This username is set to `citus` and can't be edited. |
    | Password        | Enter and confirm a strong password. |

    ![Screenshot of creating an Azure Cosmos DB for PostgreSQL in the Azure portal. The settings above are shown in the screenshot.](../media/cosmos-db-for-postgresql-basics-tab.png)

    > Note the server name and password for later use.

5. For the **Scale** setting, select **Configure** and on the node configuration page, set the following:

    | Parameter        | Value |
    | ---------------- | ----- |
    | **Nodes**            |       |
    | Node count       |  Choose **2 nodes + coordinator**. |
    | Compute per node | Select **4 vCores, 32 GiB RAM**. |
    | Storage per node | Select **512 GiBM**. |
    | **Coordinator**      |       |
    | Coordinator compute | Select **4 vCores, 16 GiB RAM**. |
    | Coordinator storage | Select **512 GiBM**. |
    | High availability | Leave unchecked. |

    ![Screenshot of the Azure Cosmos DB for PostgreSQL cluster configuration dialog. The settings above appear in the screenshot.](../media/cosmos-db-for-postgresql-cluster-config.png)

6. Select **Save** on the scale page to return to the cluster configuration.

7. Select the **Next : Networking >** button to move on to the **Networking** tab of the configuration dialog.

8. On the **Networking** tab, set the **Connectivity method** to **Public access (allowed IP addresses)**, and check the **Allow public access from Azure services and resources within Azure to this cluster** box.

    ![Screenshot of Azure Cosmos DB for PostgreSQL networking configuration. Public access (allowed IP addresses) is highlighted for the Connectivity method. Allow public access from Azure services is checked and highlighted.](../media/cosmos-db-for-postgresql-networking-tab.png)

9. Select the **Review + create** button and on the review screen, select **Create** to create your Azure Cosmos DB for PostgreSQL cluster.

## Connect to the database using psql in the Azure Cloud Shell

1. Once the Azure Cosmos DB for PostgreSQL cluster is created, navigate to the resource in the Azure portal.

2. On the navigation, under **Settings**, select **Connection strings**. Copy the connection string labeled **psql**.

    ![Screenshot of the Connection strings page of the Azure Cosmos DB Cluster resource. The 'Connection strings' navigation is highlighted. The psql connection string is also highlighted.](../media/psql-connection-string.png)

3. Open [Azure Cloud Shell](https://shell.azure.com/) in a web browser.

4. Select **Bash**.

    ![Screenshot of Azure Cloud Shell welcome message with a prompt to choose an environment between Bash or PowerShell. Bash is selected.](../media/azure-cloud-shell-welcome.png)

5. If prompted, select the subscription you used for your Azure Cosmos DB for PostgreSQL account. Then select **Create storage**.

    ![Screenshot of Azure Cloud Shell welcome wizard showing no storage mounted. Azure Subscription (the current subscription) is showing in the Subscription dropdown.](../media/azure-cloud-shell-mount-storage.png)

6. Now, use the psql command-line utility to connect to Azure Cosmos DB for PostgreSQL. Copy the connection string from Step 2, and paste it into the Cloud Shell. Update the `password` part of the connection string to use the password set-up when creating the Azure Cosmos DB for PostgreSQL cluster. Then, run the command.

## Create tables

Once the account is created, then tables can be added. Use `psql` in Azure Cloud Shell to interact with the database.

### Create local tables

Local tables, reference tables, and distribution tables start as a local table on the coordinator node.

The code below creates the `event_types`, `payment_events`, `payment_users`, and `payment_merchants` tables with their traditional primary key relationships. The foreign keys for the distributed tables will be added later.

```sql
CREATE TABLE event_types 
(
    event_type_id bigint PRIMARY KEY,
    event_type text
);

CREATE TABLE payment_users
(
    user_id bigint,
    url text,
    login text,
    avatar_url text
);

CREATE TABLE payment_merchants
(
    merchant_id bigint PRIMARY KEY,
    name text,
    url text
);

CREATE TABLE payment_events
(
    event_id bigint,
    user_id bigint,
    event_type_id bigint REFERENCES event_types (event_type_id),
    merchant_id bigint REFERENCES payment_merchants (merchant_id),
    event_details jsonb,
    created_at timestamp
) PARTITION BY RANGE (created_at);

```

### Confirm that the tables are created and not yet distributed

1. Confirm the tables are created by running the following command:

    ```sql
    \dt
    ```

    This query result should show four rows, a row for each of the tables.

    ```bash
                        List of relations
    Schema |       Name        |       Type        | Owner 
    --------+-------------------+-------------------+-------
    public | event_types       | table             | citus
    public | payment_events    | partitioned table | citus
    public | payment_merchants | table             | citus
    public | payment_users     | table             | citus
    ```

2. Use the `citus_tables` view to ensure these newly created tables aren't yet distributed. Run the following query:

    ```sql
    SELECT * FROM citus_tables;
    ```

    This query's results should show zero rows.

Now that these tables are created, let's look at choosing distribution columns for the tables we want to distribute.
