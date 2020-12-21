An Azure Stream Analytics job supports three input types:

> [!div class="mx-tableFixed"]
> | Input Type | Use case |
> |------------|----------|
> | **Azure Event Hub** | Azure Event Hub consumes live streaming data from applications with low latency and high throughput. |
> | **Azure IoT Hub**   | Azure IoT Hub consumes live streaming events from IoT devices. This service enables bi-directional communication scenarios where commands can be sent back to IoT devices to trigger specific actions based on analyzing streams they send to the service. |
> | **Azure Blob Storage** | Azure Blob Storage is used as the input source to consume files persisted in blob storage. |

## Create the input source

Let's use an Azure Blob store as the input. Recall that Azure Blob Storage has three aspects to it: the Storage account to provide the globally unique namespace in Azure, the container which acts like a folder, and the blob itself which is similar to a file in a file system.

Let's start by creating an Azure Blob Storage account.

1. Switch back to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select **All services** in the left sidebar.
1. Type "**storage**" in the search field and select **Storage accounts** from the results.
1. Click **Add** to create a new Azure Storage account.
1. On the **Basics** tab, select the new **mslearn-streamanalytics** resource group.
1. Set the Storage account name to a unique name - try using the prefix "streamsrc" with your initials or a numeric value. This value has to be unique across all Azure storage accounts, so you might have to try a few combinations to find one that works for you. The portal will place a green checkmark next to the name if it's valid.
1. Check the Location - you can set it to the same location as the job to avoid having to pay to transfer data between regions.

    > **TIP**
    >
    > This isn't absolutely necessary, but can be a cost-savings measure if you plan to have a lot of data flowing in or out of storage accounts.

1. Leave the rest of the fields as default values.

    ![Screenshot showing how to create a storage account named "streamsrc"](../media/4-add-storage-account.png)

1. Select **Review + create**.
1. Once the request has been validated, select **Create** to submit the deployment request.

Wait for a few moments for the deployment to complete, once you receive the message "Your deployment is complete" go to the next step.

## Connect the input source to the Stream Analytics job

Next, let's connect our Stream Analytics job to our new Blob Storage account.

1. In the Azure portal, Select **All services** in the left sidebar.
1. In the search box, type in **Stream Analytics**. Select the **Stream Analytics jobs** from the results.
1. In the list of jobs, select the Stream Analytics job you created earlier (**SimpleTransformer**). This will display the overview page for your job.

    ![Screenshot of the job in the Azure portal](../media/4-stream-job-overview.png)

1. Under **Job topology**, select **Inputs**.
1. Select **Add stream input** and select **Blob storage/ADLS Gen2** from the drop-down list.
1. Type **streaminput** in **Input alias** field - this is a friendly name you use to identify the input.
1. Select the storage account you created earlier - recall it starts with **streamsrc**.
1. Select **Create New** for Container field and give it a unique name such as **learncontainer**.
1. Enter **input/** for Path pattern.
1. Leave the rest of the fields as the current default values.

    > **NOTE**
    >
    > If the job and storage account are in different locations, you'll get a warning as shown in the following image.

    ![Screenshot of the interface where you define the input, showing a warning message](../media/4-create-blob-input.png)
    
1. Select **Save** to associate the input.