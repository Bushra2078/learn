To interact with individual blobs in Blob Storage, use a `BlobClient` object.  You will get a `BlobClient` by requesting it with the blob's name from the `BlobContainerClient` in which the blob is located. `BlobClient` has methods to upload, download, and manage individual blobs in Blob Storage.

## Getting a BlobClient object

::: zone pivot="csharp"

To get a `BlobClient` by name, call the `GetBlobClient` methods on the `BlobContainerClient` that contains the blob with the name of the blob.  A `BlobClient` object allows you to interact with the blob; that is upload, download, or manage the blob in Blob Storage.

Moving data to and from a blob is a network operation that takes time. The Azure Storage SDK for .NET provides asynchronous implementation of all methods that require network activity.  We recommend using these async implementations whenever possible in your application.

We also recommend using streams instead of in-memory structures like bite arrays or strings when you're working with large data objects. This method avoids buffering the full content in memory before sending it to the target. ASP.NET Core supports reading and writing streams from requests and responses.

::: zone-end

::: zone pivot="java"

To get an `BlobClient` by name, call the `getBlobClient` methods on the `BlobContainerClient` that contains the blob with the name of the blob.  A `BlobClient` object allows you to interact with the blob; that is upload, download or manage the blob in Blob Storage.

A recommendation when working with large data objects is to use streams instead of in-memory structures like byte arrays or strings. This avoids buffering the full content in memory before sending it to the target.

::: zone-end

## Create new blobs

::: zone pivot="csharp"

To create a new blob, call one of the `Upload` methods on a reference to a blob that doesn't exist in storage. This does two things: creates the blob in storage, and uploads the data.

```csharp
BlobClient blobClient = containerClient.GetBlobClient(name);

var response = blobClient.UploadAsync(fileStream);
```

::: zone-end

::: zone pivot="java"

To create a new blob, call one of the `upload` methods on a reference to a blob that doesn't exist in storage. This does two things: creates the blob in storage, and uploads the data.

```java
BlobClient blobClient = blobContainerClient.getBlobClient(name);
blobClient.upload(inputStream, contentLength);
```

::: zone-end

## Exercise

Let's finish your app by adding upload and download code, then deploy it to Azure App Service for testing.

### Upload

::: zone pivot="csharp"

- To upload a blob, you'll implement the `BlobStorage.Save` method.  First, you will get a `BlobClient` object that represents the blob by calling `GetBlobClient` on a `BlobContainerClient`. Then, you will use the `UploadAsync` method on the `BlobClient` to save the `Stream` of data passed to this method up to Blob Storage.

    In the editor, in `BlobStorage.cs`, replace `Save` with the following code. Use CTRL + S to save your work.

    ```csharp
    public Task Save(Stream fileStream, string name)
    {
        BlobServiceClient blobServiceClient = new BlobServiceClient(storageConfig.ConnectionString);
            
        // Get the container (folder) the file will be saved in
        BlobContainerClient containerClient = blobServiceClient.GetBlobContainerClient(storageConfig.FileContainerName);

        // Get the Blob Client used to interact with (including create) the blob
        BlobClient blobClient = containerClient.GetBlobClient(name);

        // Upload the blob
        return blobClient.UploadAsync(fileStream);
    }
    ```

    > [!NOTE]
    > The stream-based upload code shown here is more efficient than reading the file into a byte array before sending it to Blob Storage. However, the ASP.NET Core `IFormFile` technique you use to get the file from the client is not a true end-to-end streaming implementation, and is only appropriate for handling uploads of small files.

::: zone-end

::: zone pivot="java"

- To upload a blob, you'll implement the `BlobStorage.save` method.  First, you will get a `BlobClient` object that represents the blob by calling `getBlobClient` on a `BlobContainerClient`. Then, you will use the `upload` method on the `BlobClient` to save the `InputStream` of data passed to this method up to Blob Storage.

    In the editor, in `BlobStorage.java`, replace `save` with the following code.

    ```java
    public void save(String name, InputStream inputStream, long contentLength) {
        BlobClient blobClient = blobContainerClient.getBlobClient(name);
        blobClient.upload(inputStream, contentLength);
    }
    ```

::: zone-end

### Download

::: zone pivot="csharp"

To download a file, the `OpenReadAsync` method on the `BlobClient` object is returned. This method returns a `Stream`, meaning that your code doesn't need load all of the bytes from Blob Storage at once &mdash; you just need to return a reference to the blob stream which can be used by ASP.NET Core to stream the file to the browser.

- Replace `Load` with this code and save your work using CTRL + S.

    ```csharp
    public Task<Stream> Load(string name)
    {
        BlobServiceClient blobServiceClient = new BlobServiceClient(storageConfig.ConnectionString);
    
        // Get the container the blobs are saved in
        BlobContainerClient containerClient = blobServiceClient.GetBlobContainerClient(storageConfig.FileContainerName);
    
        // Get a client to operate on the blob so we can read it.
        BlobClient blobClient = containerClient.GetBlobClient(name);
                
        return blobClient.OpenReadAsync();
    }
    ```

::: zone-end

::: zone pivot="java"

To download a file use the `openInputStream` method on the `BlobClient`. This method returns an `InputStream`, meaning that your code doesn't need load all of the bytes from Blob Storage at once &mdash; you just need to return a reference to the blob stream which can be used by `IndexBean` to stream the content to the browser.

- Replace `read` with this code and save your work.

    ```java
    public InputStream read(String name) {
        BlobClient blobClient = blobContainerClient.getBlobClient(name);
        return blobClient.openInputStream();
    }
    ```

::: zone-end

### Deploy and run in Azure

::: zone pivot="csharp"

1. Your app is finished, so let's deploy it and see it work. Create an App Service app and configure it with app settings for your storage account connection string and container name. Get the storage account's connection string with `az storage account show-connection-string`, and set the name of the container to be `files`.

    The app name needs to be globally unique, so you'll need to choose your own name to fill in `<your-unique-app-name>`. You'll also use the storage account name you created previously to replace `<your-unique-storage-account-name>`. Run each of the following commands in the below order in Azure CLI:

    ```azurecli
    az appservice plan create \
    --name blob-exercise-plan \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --sku FREE --location centralus
    ```

    ```azurecli
    az webapp create \
    --name <your-unique-app-name> \
    --plan blob-exercise-plan \
    --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    ```azurecli
    CONNECTIONSTRING=$(az storage account show-connection-string \
    --name <your-unique-storage-account-name> \
    --output tsv)
    ```

    ```azurecli
    az webapp config appsettings set \
    --name <your-unique-app-name> --resource-group <rgn>[sandbox resource group name]</rgn> \
    --settings AzureStorageConfig:ConnectionString=$CONNECTIONSTRING AzureStorageConfig:FileContainerName=files
    ```

1. Now, you'll deploy your app. The following commands will publish the site to the `pub` folder, zip it up into `site.zip`, and deploy the zip to App Service.

    > [!NOTE]
    > Make sure your shell is still in the `mslearn-store-data-in-azure/store-app-data-with-azure-blob-storage/src/start` directory before running the following commands.  You can use `cd mslearn-store-data-in-azure/store-app-data-with-azure-blob-storage/src/start` to change directory to this location. 

    ```azurecli
    dotnet publish -o pub
    cd pub
    zip -r ../site.zip *
    ```

    ```azurecli
    az webapp deployment source config-zip \
    --src ../site.zip \
    --name <your-unique-app-name> \
    --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    To see the running app, in a browser, open `https://<your-unique-app-name>.azurewebsites.net`. It should look like the following image.

    :::image type="content" source="../media/7-fileuploader-empty.PNG" alt-text="Screenshot of the FileUploader web app." loc-scope="other"::: <!-- no-loc -->

1. Try uploading and downloading some files to test the app. After you've uploaded a few files, to see the blobs that have been uploaded to the container, run the following code in the shell, replacing `<your-unique-storage-account-name>` with the storage account name you created earlier in the module:

    ```console
    az storage blob list --account-name <your-unique-storage-account-name> --container-name files --query [].{Name:name} --output table
    ```

::: zone-end

::: zone pivot="java"

1. Your app is finished, so let's deploy it and see it work. Create an App Service app and configure it with app settings for your storage account connection string and container name. Get the storage account's connection string with `az storage account show-connection-string`, and set the name of the container to be `files`.

    The app name needs to be globally unique, so you'll need to choose your own name to fill in `<your-unique-app-name>`.

    ```azurecli
    az appservice plan create \
    --name blob-exercise-plan \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --is-linux \
    --sku FREE --location centralus
    ```

    ```azurecli
    az webapp create \
    --name <your-unique-app-name> \
    --plan blob-exercise-plan \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --runtime "TOMCAT|9.0-java11"
    ```

    ```console
    CONNECTIONSTRING=$(az storage account show-connection-string \
    --name <your-unique-storage-account-name> \
    --output tsv)
    ```

    ```azurecli
    az webapp config appsettings set \
    --name <your-unique-app-name> --resource-group <rgn>[sandbox resource group name]</rgn> \
    --settings STORAGE_CONNECTION_STRING=$CONNECTIONSTRING STORAGE_CONTAINER_NAME=files
    ```

1. Now, you'll deploy your app. The following commands will build the app into `ROOT.war`, and deploy the WAR file to App Service.

    > [!NOTE]
    > Make sure your shell is still in the `mslearn-store-data-in-azure/store-java-ee-application-data-with-azure-blob-storage/start` directory before running the following commands.  You can use `cd mslearn-store-data-in-azure/store-java-ee-application-data-with-azure-blob-storage/start` to change directory to this location. 

    ```bash
    ./mvnw clean package
    ```

    ```azurecli
    az webapp deploy \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-unique-app-name> \
    --src-path target/ROOT.war
    ```

    To see the running app, in a browser, open `https://<your-unique-app-name>.azurewebsites.net`. It should look like the following image.

    :::image type="content" source="../media/7-fileuploader-empty-java.PNG" alt-text="Screenshot of the FileUploader web app." loc-scope="other"::: <!-- no-loc -->

1. Try uploading and downloading some files to test the app. After you've uploaded a few files, to see the blobs that have been uploaded to the container, run the following code in the shell.

    ```console
    az storage blob list --account-name <your-unique-storage-account-name> --container-name files --query [].{Name:name} --output table
    ```

::: zone-end