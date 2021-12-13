Your company applications currently use traditional file protocols such as NFS, and they want to use an NFS client to access data from Blob Storage. Using an NFS client will provide additional benefits such as processing with high throughput and high scaling from the object storage account.

### NFS 3.0 protocol support in Azure Blob Storage

Blob Storage supports the NFS 3.0 protocol, which provides users with the following benefits:

- You can use NFS-enabled applications to directly access data over object storage. 
- You can benefit from media processing, which often requires high throughput and high scale.
- Linux clients can seamlessly mount a container in Blob Storage.

**Note**: Windows client for NFS is not yet supported.

Blob Storage support for the NFS 3.0 protocol requires a hierarchical namespace, which Azure Data Lake Storage Gen2 offers. Azure stores all the data in the storage account that’s enabled for NFS 3.0 support as block blobs. 

For performance tuning, use virtual machines with sufficient network bandwidth combined with multiple mount points. Ensure that applications that access content over the NFS 3.0 protocol support multiple threads and large block sizes. If your applications require low latency and high throughput, you can combine the storage account with Azure HPC Cache. 

### Enable support for NFS in Azure Blob Storage

Perform the following tasks to enable NFS support in your Azure Blob Storage:

1. Enable support for the NFS 3.0 protocol in your subscription. To do this, enter the following commands in the Azure CLI:

  `az feature register --namespace Microsoft.Storage --name AllowNFSV3`

  `az feature register --namespace Microsoft.Storage --name PremiumHns`

2. Secure the data access by enabling Blob Storage access from within the virtual network. To do this, you can use private endpoints that assign a private IP to the storage accounts and helps secure all traffic between your NFS clients and the storage account over a private link.

3. Create a container within the storage accounts, and then mount that container using a client that supports the NFS 3.0 protocol.

4. Use the following code to mount a container using a NFS 3.0 client. Replace the values for <_nameofthestoraggeaccount_> and <_nameofthecontainer_> with names that correspond to your environment.

```
Sudo mount -o sec=sys,vers=3,nolock,proto=tcp <nameofthestorageaccount>.blob.core.windows.net:/<nameofthestorageaccount>/<nameofthecontainer>  /mnt/blob
```

**Note:** When you create an NFS 3.0 storage account, the GRS, GZRS, and RA-GRS redundancy options aren’t supported.

You can optimize the performance of the storage request used by the NFS client by adding more clients, or by using an Azure premium block blob storage account.
