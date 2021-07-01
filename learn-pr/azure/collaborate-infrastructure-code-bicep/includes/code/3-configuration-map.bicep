@description('The location into which your Azure resources should be deployed.')
param location string = resourceGroup().location

@description('Select what environment you want to provision. Allowed values are Production and Test.')
@allowed([
  'Production'
  'Test'
])
param environmentType string = 'Test'

var appServicePlanName = 'MyAppServicePlan'

var environmentConfigurationMap = {
  Production: {
    appServicePlan: {
      name: 'P2V3'
      capacity: 3
    }
    storageAccount: {
      name: 'ZRS'
    }
  }
  Test: {
    appServicePlan: {
      sku: {
        name: 'S2'
        capacity: 1
      }
    }
    storageAccount: {
      sku: {
        name: 'LRS'
      }
    }
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: environmentConfigurationMap[environmentType].appServicePlan.sku
}
