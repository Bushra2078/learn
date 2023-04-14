You've decided to evaluate the AzCopy command as an alternative to using the Azure CLI. As before, you want to move blobs that contain the details for product specifications, and that are more than six months old, to an archive store in a separate Blob Storage account.

In this exercise, you'll investigate how to use the AzCopy to migrate blobs that haven't changed in the last six months to a separate storage account.

## Create and add data to hot storage

First, create two accounts by using the Azure CLI.

  [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

1. Create environment variables for your storage account name and region. Replace `<location>` with a region from the previous list.

    ```azurecli
    HOT_STORAGE_NAME=hotstorage$RANDOM
    COOL_STORAGE_NAME=coolstorage$RANDOM
    LOCATION=<location>
    ```

2. Next, run the following command to create a storage account to hold blobs.

    ```azurecli
    az storage account create \
      --location $LOCATION \
      --name $HOT_STORAGE_NAME \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --sku Standard_RAGRS \
      --kind BlobStorage \
      --access-tier Hot
    ```

3. Create a storage account for holding the archived blobs. Use the **Cool** access tier. As before, specify an appropriate region, and choose a unique name for your storage account.

    ```azurecli
    az storage account create \
      --location $LOCATION \
      --name $COOL_STORAGE_NAME \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --sku Standard_RAGRS \
      --kind BlobStorage \
      --access-tier Cool
    ```

## Setup

We'll start by downloading the latest version of AzCopy; currently version 10. The Azure CLI does include AzCopy, but it may be an older version. We'll also generate SAS tokens for our storage accounts and then upload some sample data.

1. In the Cloud Shell window, run the following commands to download and extract the most recent version of *AzCopy* for Linux.

    ```bash
    wget -O azcopy.gz https://aka.ms/downloadazcopy-v10-linux
    gunzip azcopy.gz
    tar xvf azcopy
    ```

<!-- NOTE TO REVIEWER. I wanted to generate SAS tokens from the command line, using the Azure CLI. However, there are currently bugs in the CLI storage commands which cause dates and timestamps to be handled incorrectly (may also be responsible for some of the issues in Exercise 4), so I have used the portal to generate SAS tokens. -->

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account you used to activate the Sandbox.

1. Select **All resources**, and select your destination (cool) storage account.

1. On the storage account page, under **Security + networking**, select **Shared access signature**.

1. On the shared access signature page, check **Container** and **Object** under the **Allowed resource types** section.

1. With the allowed resource types checked, select **Generate SAS and connection string** at the bottom of the shared access signature page.

1. In the Cloud Shell, create an environment variable to assign the generated **SAS token** value from the portal.

    ```bash
    COOL_SAS_TOKEN="<token from portal>"
    ```

1. Repeat these steps, and assign a generated SAS token for the hot storage account to a variable named **HOT_SAS_TOKEN**.

    ```bash
    HOT_SAS_TOKEN="<token from portal>"
    ```

1. Run the following command to download the sample files for this exercise.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-copy-move-blobs-from-containers-or-storage-accounts sample

## Create a container for holding archived blobs

1. In the Cloud Shell, navigate to the directory containing the *AzCopy* utility, replacing `<version>` with the version number downloaded with the latest AzCopy release. You can find the directory name with the `dir` command.

    ```bash
    cd azcopy_linux_amd64_<version>
    ```

2. Create a new container named *azcopy-archive* in the cool storage destination for the archived content from this AzCopy command line process.

    ```bash
    ./azcopy make https://$COOL_STORAGE_NAME.blob.core.windows.net/azcopy-archive$COOL_SAS_TOKEN
    ```

    Verify that the command responds with the message, *Successfully created the resource*.

3. Create a new container named *specifications* in the hot storage destination to hold fictious specification files.

   ```bash
   ./azcopy make https://$HOT_STORAGE_NAME.blob.core.windows.net/specifications$HOT_SAS_TOKEN
   ```

    Verify that the command responds with the message, *Successfully created the resource*.

4. Upload the files to your storage account and save each one as a blob. This command uploads several specification files.

   ```bash
   ./azcopy copy "../sample/specifications/*" "https://$HOT_STORAGE_NAME.blob.core.windows.net/specifications$HOT_SAS_TOKEN"
   ```

## Copy blobs to *Cool* storage

1. In the Cloud Shell, run the following command to generate a list of blobs and their last modified times in the source container.

    ```bash
    az storage blob list \
      --account-name $HOT_STORAGE_NAME \
      --container-name "specifications" \
      --sas-token $HOT_SAS_TOKEN \
      --query '[].{name:name, properties:properties.lastModified}'
    ```

1. Now that you have a list of blobs and their last modified times, you can use this information to create a script that uses AzCopy to transfer each blob that has a last modified time of more than six months ago to *Cool* storage. Because these files were just added, none of them will be old enough to filter by six months. Instead, run this example command to copy the *specification01.md* file to this new cool storage container.

    ```bash
    ./azcopy copy https://$HOT_STORAGE_NAME.blob.core.windows.net/specifications/specification01.md$HOT_SAS_TOKEN https://$COOL_STORAGE_NAME.blob.core.windows.net/azcopy-archive$COOL_SAS_TOKEN
    ```

1. The blob being copied is small and the transfer will complete quickly, but imagine that the blob is several gigabytes in size. The transfer would take much longer. Run the following command to view AzCopy jobs that have run recently, or are still running.

    ```bash
    ./azcopy jobs list
    ```

    Make a note of the *JobId* for the transfer operation.

1. Run the following command to determine the status of the job. Replace *\<jobid>* with the job ID that you noted in the previous step.

    ```bash
    ./azcopy jobs show <jobid>
    ```

1. Verify that the blob has been copied. Run the following command to list the blobs in the *azcopy-archive* container in the destination storage account.

    ```bash
    ./azcopy list https://$COOL_STORAGE_NAME.blob.core.windows.net/azcopy-archive$COOL_SAS_TOKEN
    ```

## Remove blobs from *Hot* storage

1. Copying a blob to *Cool* storage doesn't remove the blob from *Hot* storage. You must delete these blobs manually. As an example, run the following command to delete the "specification01.md" blob from the source (hot) storage account.

    ```bash
    ./azcopy remove https://$HOT_STORAGE_NAME.blob.core.windows.net/specifications/specification01.md$HOT_SAS_TOKEN
    ```
