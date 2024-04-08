@description('The Azure region where the Bastion should be deployed')
param location string = 'global'
param region string = 'uksouth'
param environment string = 'hub'
param prefix string = 'nsmuk'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: '${environment}'
  Role: 'Network'
  CreationDate: dateTime

}

resource privatednszone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'dnszone.kingfisher.com'
  location: location
  tags: tagValues
}
