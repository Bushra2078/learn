You deployed Azure File Sync, and created trust relationships between Azure and your on-premises server. By deploying Azure File Sync, you extended your on-premises file server storage capacity to include large CAD files.
    
- You learned what Azure File Sync is and how to use it.
- You learned how to assess the compatibility of your server.
- You saw how to set up Azure resources that are needed to support Azure File Sync.
- You set up and configured Azure File Sync on a Windows Server.
- You learned how to troubleshoot Azure File Sync issues.

## Clean up

When you're working in your own subscription, it's a good idea at the end of a project to identify whether you still need the resources you created. Resources left running can cost you money.

Delete the Azure File Sync resources individually, and in the following reverse order you created them:

1. In Azure, delete the server and cloud endpoints in the sync group.
1. Delete the sync group.
1. Delete the Storage Sync Service.
1. You can delete the rest of the resources you created by deleting the resource group that contain the remaining resources.

## Learn more

- [Planning for an Azure File Sync deployment](https://docs.microsoft.com/azure/storage/files/storage-sync-files-planning)
- [Deploy Azure File Sync](https://docs.microsoft.com/azure/storage/files/storage-sync-files-deployment-guide)
- [Troubleshoot Azure File Sync](https://docs.microsoft.com/azure/storage/files/storage-sync-files-troubleshoot)
