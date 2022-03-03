@description('Specifies whether the storage account is ready to be deployed.')
param storageAccountReady bool = false

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = if (storageAccountReady) {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}
