param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'hub'
param prefix string = 'nsmuk'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: environment
  Role: 'Network'
  CreationDate: dateTime

}

resource vgwPublicIp 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: 'pip-vgw-${prefix}-${environment}-${region}-001'
  location: location
  tags: tagValues
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}
