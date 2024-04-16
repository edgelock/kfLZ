param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'platform'
param prefix string = 'nsmuk'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: '${environment}'
  Role: 'Network'
  CreationDate: dateTime
}

param zones array = [
  'privatelink.vaultcore.azure.net'
  'privatelink.blob.core.windows.net'
]
resource pdnsz 'Microsoft.Network/privateDnsZones@2020-06-01' = [for zone in zones : {
  name: zone
  location: 'Global'
  tags: tagValues
}]
