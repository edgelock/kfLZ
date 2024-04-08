param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'hub'
param prefix string = 'nsmuk'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'Kingfisher'
  Department: 'Infrastructure'
  Environment: '${environment}'
  Role: 'Network'
  CreationDate: dateTime
}
param virtualNetworkId string = '/subscriptions/19022fa5-e4d8-4433-bd3c-503455903ca2/resourceGroups/rg-nsmuk-hub-network-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-nsmuk-hub-uksouth-001'
param subnetName string = 'AzureFirewallSubnet'

resource firewallPublicIp 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: 'pip-${prefix}-${environment}-${region}-001'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

output id string = firewallPublicIp.id

