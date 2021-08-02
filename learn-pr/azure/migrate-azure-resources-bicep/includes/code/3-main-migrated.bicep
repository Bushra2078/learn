param virtualMachines_ToyTruckServer_name string = 'ToyTruckServer'
param networkInterfaces_toytruckserver686_name string = 'toytruckserver686'
param publicIPAddresses_ToyTruckServer_ip_name string = 'ToyTruckServer-ip'
param networkSecurityGroups_ToyTruckServer_nsg_name string = 'ToyTruckServer-nsg'
param virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name string = 'learn-b44b5d84-e9a2-4b1b-8d33-fdf6122b54ad-vnet'
param networkSecurityGroups_NSG_westus_externalid string = '/subscriptions/8952eed4-dfa3-4518-93d0-62f8a8ae0d0c/resourceGroups/SandboxNSGs/providers/Microsoft.Network/networkSecurityGroups/NSG-westus'

resource networkSecurityGroups_ToyTruckServer_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_ToyTruckServer_nsg_name
  location: 'westus'
  properties: {
    securityRules: []
  }
}

resource publicIPAddresses_ToyTruckServer_ip_name_resource 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_ToyTruckServer_ip_name
  location: 'westus'
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '13.64.89.79'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name
  location: 'westus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroups_NSG_westus_externalid
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualMachines_ToyTruckServer_name_resource 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: virtualMachines_ToyTruckServer_name
  location: 'westus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_ToyTruckServer_name}_OsDisk_1_3b5a980955c54f1c838b7efa21e1ddd3'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_ToyTruckServer_name}_OsDisk_1_3b5a980955c54f1c838b7efa21e1ddd3')
        }
        diskSizeGB: 30
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_ToyTruckServer_name
      adminUsername: 'toytruckadmin'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_toytruckserver686_name_resource.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name_resource
  name: 'default'
  properties: {
    addressPrefix: '10.0.0.0/24'
    networkSecurityGroup: {
      id: networkSecurityGroups_NSG_westus_externalid
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource networkInterfaces_toytruckserver686_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_toytruckserver686_name
  location: 'westus'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_ToyTruckServer_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_learn_b44b5d84_e9a2_4b1b_8d33_fdf6122b54ad_vnet_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    networkSecurityGroup: {
      id: networkSecurityGroups_ToyTruckServer_nsg_name_resource.id
    }
  }
}
