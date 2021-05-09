param deployStorageAccount bool

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-01-01' = if (deployStorageAccount) {
  name: 'toystorage'
  location: resourceGroup().location
  kind: 'StorageV2'
  // ...
}
