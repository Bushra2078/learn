## Create a storage account

In this task, we will create a new storage account.

1.  Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true)
2.  Select Create a resource.
3.  Under Categories, select Storage.
4.  Unders Storage Account, select Create.
5.  On the Basics tab of the Create storage account blade, fill in the following information. Leave the defaults for everything else.
    
    Setting | Value --------- | --------- Subscription | Default (Concierge) Resource Group | 
    [sandbox resource group name]
    Storage account name | User-defined Location | Default Performance | Standard Redundancy | Locally redundant storage (LRS)
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Leave provided default
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        \[sandbox resource group name\]
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Storage account name
      :::column-end:::
      :::column:::
        create a unique storage account name
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Location
      :::column-end:::
      :::column:::
        default
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Performance
      :::column-end:::
      :::column:::
        Standard
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Redundancy
      :::column-end:::
      :::column:::
        Locally redundant storage (LRS)
      :::column-end:::
    :::row-end:::
    
6.  Select Review + Create to review your storage account settings and allow Azure to validate the configuration.
7.  Once validated, select Create. Wait for the notification that the account was successfully created.
8.  Select Go to resource.

## Work with blob storage

In this section, you'll create a Blob container and upload a picture

1.  Under Data storage, select Containers.
    
    :::image type="content" source="../media/storage-account-menu-9472480e.png" alt-text="Screenshot of the Container add section of a storage account.":::
    
2.  Select + Container and complete the information.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        Enter a name for the container
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Public access level
      :::column-end:::
      :::column:::
        Private (no anonymous access)
      :::column-end:::
    :::row-end:::
    
3.  Select Create.
4.  Step 5 will need an image. If you want to upload an image you already have on your computer, continue to Step 5. Otherwise, open a new browser window and search Bing for an image of a flower. Save the image to your computer.
5.  Back in the Azure Portal select the container you created, then select Upload.
6.  Browse for the image file you want to upload. Select it and then select upload.

    > [!NOTE]
    > Note: You can upload as many blobs as you like in this way. New blobs will be listed within the container.

7.  Select the Blob (file) you just uploaded. You should be on the properties tab.
8.  Copy the URL from the URL field and paste it into a new tab.
    
    You should receive an error message similar to the following.
    
    ```
    <Error>
      <Code>ResourceNotFound</Code>
      <Message>The specified resource does not exist. RequestId:4a4bd3d9-101e-005a-1a3e-84bd42000000 Time:2022-06-20T00:41:31.2482656Z</Message>
    </Error>
    
    ```

## Change the access level of your blob

1.  Go back to the Azure Portal
2.  Select Change access level
3.  Set the Public access level to Blob (anonymous read access for blobs only)
    
    :::image type="content" source="../media/blob-access-level-213a74e6.png" alt-text="Screenshot with Change access level highlighted.":::
    
4.  Select OK
5.  Refresh the tab where you attempted to access the file earlier.

Congratulations - you've completed this exercise. You created a storage account, added a container to the storage account, and then uploaded blobs (files) to your container. Then you changed the access level so you could access your file from the internet.

[!include[](../../../includes/azure-sandbox-cleanup.md)]
