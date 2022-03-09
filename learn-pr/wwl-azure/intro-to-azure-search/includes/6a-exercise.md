Let's imagine you work for Fourth Coffee, a national coffee chain. You're asked to help build a knowledge mining solution that makes it easy to search for insights about customer experiences. You decide to build an Azure Cognitive Search index using data extracted from customer reviews.  

In this lab you'll:

- Create Azure resources
- Extract data from a data source
- Enrich data with AI skills
- Use Azure's indexer in the Azure portal
- Query your search index
- Review results saved to a Knowledge Store

## Azure resources needed

The solution you'll create for Fourth Coffee requires the following resources in your Azure subscription:

- An **Azure Cognitive Search** resource, which will manage indexing and querying.
- A **Cognitive Services** resource, which provides AI services for skills that your search solution can use to enrich the data in the data source with AI-generated insights.

    > [!NOTE]
    > Your Azure Cognitive Search and Cognitive Services resources must be in the same location!

- A **Storage account** with blob containers, which will store raw documents and other collections of tables, objects, or files.

### Create an *Azure Cognitive Search* resource

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

2. Click the **+ Create a resource** button, search for *Azure Cognitive Search*, and create a **Azure Cognitive Search** resource with the following settings:

    - **Subscription**: *Your Azure subscription*.
    - **Resource group**: *Select or create a resource group with a unique name*.
    - **Service name**: *A unique name*
    - **Location**: *Choose any available region*
    - **Pricing tier**: Basic

3. Select **Review + create**, and after you see the response **Validation Passed**, select **Create**.

4. After deployment completes, select **Go to resource**. On the Azure Cognitive Search overview page, you can add indexes, import data, and search created indexes.

### Create a Cognitive Services resource

You'll need to provision a **Cognitive Services** resource that's in the same location as your Azure Cognitive Search resource. Your search solution will use this resource to enrich the data in the datastore with AI-generated insights.

1. Return to the home page of the Azure portal, and then select the **+ Create a resource** button, search for *Cognitive Services*, and create a **Cognitive Services** resource with the following settings:
    - **Subscription**: *Your Azure subscription*
    - **Resource group**: *The same resource group as your Azure Cognitive Search resource*
    - **Region**: *The same location as your Azure Cognitive Search resource*
    - **Name**: *A unique name*
    - **Pricing tier**: Standard S0
2. Select the required checkboxes, and then select **Review + create**.
3. After you see the response **Validation Passed**, select **Create**.
4. Wait for deployment to complete, then view the deployment details.

### Create a storage account

1. Return to the home page of the Azure portal, and then select the **+ Create a resource** button.
2. Search for *storage account*, and create a **Storage account** resource with the following settings:
    - **Subscription**: *Your Azure subscription*
    - **Resource group**: *The same resource group as your Azure Cognitive Search and Cognitive Services resources*
    - **Storage account name**: *A unique name*
    - **Location**: *Choose any available location*
    - **Performance**: Standard
    - **Redundancy**: Locally-redundant storage (LRS)
3. Click **Review + Create** and then click **Create**. Wait for deployment to complete, and then go to the deployed resource.

## Upload Documents to Azure Storage

1. Select **Go to resource** to access the Azure Storage account you created. In the left-hand menu pane, select **Containers**.

    :::image type="content" source="../media/storage-blob-1.png" alt-text="Screenshot that shows the storage blob overview page.":::

2. Select **+ Container**. A pane on your right-hand side opens.

    :::image type="content" source="../media/storage-blob-2.png" alt-text="Screenshot that shows the creation of a storage container.":::

    Enter the following settings:
    - **Name**: coffee-reviews  
    - **Public access level**: Container (anonymous read access for containers and blobs)
    - **Advanced**: *no changes*  
    - Click **Create**.

3. Download the zipped documents from https://aka.ms/km-documents. Then extract the files from *reviews* folder.
4. Select your *coffee-reviews* container. In the container, Select **Upload**.

    :::image type="content" source="../media/storage-blob-3.png" alt-text="Screenshot that shows the storage container.":::

5. In the Explorer window, select **all** the files in the *reviews* folder, select **Open**, and then select **Upload**.

    :::image type="content" source="../media/6a-azure-container-upload-files.png" alt-text="Screenshot that shows the files uploaded to the Azure container.":::

6. After the upload is complete, you can close the **Upload blob** pane. Your documents are now in your *coffee-reviews* storage container.

## Index the documents

Once you have the documents in storage, you can use Azure Cognitive Search to extract insights from the documents. The Azure portal provides an *Import data wizard*. With this wizard, you can automatically create an index and indexer for supported data sources. You'll use the wizard to create an index, and import your search documents from storage into the Azure Cognitive Search index.

1. In the Azure portal, browse to your Azure Cognitive Search resource. On the **Overview** page, select **Import data**.

    :::image type="content" source="../media/azure-search-wizard-1.png" alt-text="Screenshot that shows the import data wizard.":::

2. On the **Connect to your data** page, in the **Data Source** list, select **Azure Blob Storage**. Complete the data store details with the following values:
    - **Data Source**: *Choose Azure Blob Storage*
    - **Data source name**: coffee-customer-data
    - **Data to extract**: Content and metadata
    - **Parsing mode**: Default
    - **Connection string**: *Select **Choose an existing connection**. Select your storage account, select the **coffee-reviews** container, and then click **Select**.
    - **Managed identity authentication**: None
    - **Container name**: *this setting is auto-populated after you choose an existing connection*
    - **Blob folder**: *Leave this blank*
    - **Description**: Reviews for Fourth Coffee shops.
3. Select **Next: Add cognitive skills (Optional)**.
4. In the **Attach Cognitive Services** section, select your Cognitive Services resource.  
5. In the **Add enrichments** section:
    - Change the **Skillset name** to **coffee-skillset**.
    - Select the checkbox **Enable OCR and merge all text into merged_content field**.
        > [!NOTE]
        > It's important to select **Enable OCR** to see all of the enriched field options.
    - Ensure that the **Source data field** is set to **merged_content**.
    - Change the **Enrichment granularity level** to **Pages (5000 character chunks)**.
    - Don't select *Enable incremental enrichment*
    - Select the following enriched fields:

        | Cognitive Skill | Parameter | Field name |
        | --------------- | ---------- | ---------- |
        | Extract location names | | locations |
        | Extract key phrases | | keyphrases |
        | Detect Sentiment | | sentiment |
        | Generate tags from images | | imageTags |
        | Generate captions from images | | imageCaption |

6. Under **Save Enrichments to a Knowledge Store**, select:
    - Image projections
    - Documents
    - Pages
    - Key phrases
    - Entities
    - Image details
    - Image references

        > [!NOTE]
        > A warning asking for a **Storage Account Connection String** appears.
        > :::image type="content" source="../media/6a-azure-cognitive-search-enrichments-warning.png" alt-text="Screenshot that shows the Storage account connection screen warning with 'Choose an existing connection' selected.":::

7. Select **Choose an existing connection**. Choose the storage account you created earlier.
8. Click on **+ Container** to create a new container called **knowledge-store** with the privacy level set to private.
9. Select **Create**.
10. Select the **knowledge-store** container, and then click **Select** at the bottom of the screen.
11. Select **Azure blob projects: Document**. A setting for *Container name* with the *knowledge-store* container auto-populated displays. Don't change the container name.
12. Select **Next: Customize Target Index**. Change the **Index name** to **coffee-index**.
13. Ensure that the **Key** is set to **metadata_storage_path**. Leave **Suggester name** blank and **Search mode** autopopulated.
14. Review the index fields' default settings. Select **filterable** for all the fields that are already selected by default.

    :::image type="content" source="../media/6a-azure-cognitive-search-customize-index.png" alt-text="Screenshot that shows the customize index pane with the index name entered and 'Filterable' selected for a default index field.":::

15. Select **Next: Create an indexer**.
16. Change the **Indexer name** to **coffee-indexer**.
17. Leave the **Schedule** set to **Once**.
18. Expand the **Advanced** options. Ensure that the **Base-64 Encode Keys** option is selected, as encoding keys can make the index more efficient.
19. Select **Submit** to create the data source, skillset, index, and indexer. The indexer is run automatically and runs the indexing pipeline, which:
    - Extracts the document metadata fields and content from the data source.
    - Runs the skillset of cognitive skills to generate more enriched fields.
    - Maps the extracted fields to the index.
20. In the bottom half of the **Overview** page for your Azure Cognitive Search resource, select the **Indexers** tab.This tab shows the newly created **coffee-indexer**. Wait a minute, and select **&orarr; Refresh** until the **Status** indicates success.
21. Select the indexer name to see more details.

:::image type="content" source="../media/6a-search-indexer-success.png" alt-text="Screenshot that shows the coffee-indexer Indexer successfully created.":::

## Query the index

Use the Search explorer to write and test queries. Search explorer is a tool built into the Azure portal that gives you an easy way to validate the quality of your search index. You can use Search explorer to write queries and review results in JSON.

1. In your Search service's *Overview* page, select **Search explorer** at the top of the screen.

   :::image type="content" source="../media/5-exercise-screenshot-7.png" alt-text="Screenshot of how to find Search explorer.":::

2. Notice how the index selected is the *coffee-index* you created.

    :::image type="content" source="../media/search-explorer-query.png" alt-text="Screenshot of the Search explorer.":::

    In the **Query string** field, enter `search=*&$count=true`, and then select **Search**. The search query returns all the documents in the search index, including a count of all the documents in the **@odata.count** field. The search index should return a JSON document containing your search results.

3. Now let's filter by location. Enter `search=$filter=locations eq 'Chicago'`. The query searches all the documents in the  index and filters for reviews with a Chicago location.

4. Now let's filter by sentiment. Enter `search=$filter=sentiment eq 'negative'` in the **Query string** field, and then select **Search**. The query searches all the documents in the index and filters for reviews with a negative sentiment.

   > [!NOTE]
   > See how the results are sorted by `@search.score`. This is the score assigned by the search engine to show how closely the results match the given query.

5. One of the problems we might want to solve for is why there might be certain reviews. Let's take a look at the key phrases associated with the negative review. What do you think might be the cause of the review?

## Review the knowledge store

Let's see the power of the knowledge store in action. When you ran the *Import data wizard*, you also created a knowledge store. Inside the knowledge store, you'll find the enriched data extracted by AI skills persists in the form of projections and tables.

1. In the Azure portal, navigate back to your Azure storage account.
2. In the left-hand menu pane, select **Storage browser (preview)**. In the storage browser tree, select **Blob containers**. Select the **knowledge-store** container.
3. Select any of the items, and then click on the **objectprojection.json** file.

    :::image type="content" source="../media/knowledge-store-blob-1.png" alt-text="Screenshot of the objectprojection.json.":::

4. Select **Edit** to see the JSON produced for one of the documents from your Azure data store.

    :::image type="content" source="../media/knowledge-store-blob-2.png" alt-text="Screenshot of how to find the edit button.":::

5. Select the storage blob breadcrumb at the top left of the screen to return to the Storage browser's tree.

    :::image type="content" source="../media/knowledge-store-blob-4.png" alt-text="Screenshot of the storage blob breadcrumb.":::

6. Select **Blob containers** on the left-hand panel again. Select the container *coffee-skillset-image-projection*. Select any of the items.

    :::image type="content" source="../media/knowledge-store-blob-5.png" alt-text="Screenshot of the skillset container.":::

7. Select any of the *.jpg* files. Select **Edit** to see the image stored from the document. Notice how all the images from the documents are stored in this manner.

    :::image type="content" source="../media/knowledge-store-blob-3.png" alt-text="Screenshot of the saved image.":::

8. Select the storage blob breadcrumb at the top left of the screen to return to the Storage browser's tree.
9. Select **Tables** on the left-hand panel. There's a table for each entity in the index. Select the table *coffeeSkillsetKeyPhrases*.

    Look at the key phrases the knowledge store was able to capture from the content in the reviews. Many of the fields are keys, so you can link the tables like a relational database. The last field shows the key phrases that were extracted by the skillset.

## Learn more

This simple search index only some of the capabilities of the Azure Cognitive Search service. To learn more about what you can do with this service, see the [Azure Cognitive Search service page](/azure/search/search-what-is-azure-search).
