param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'platform'
param prefix string = 'nsmuk'
param dateTime string = utcNow('d')
param tenantid string = '5aa0bc1f-6fd3-47dd-bd49-29fd2b62b56a'
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: '${environment}'
  Role: 'Network'
  CreationDate: dateTime
}

resource keyvault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'kv${prefix}${environment}${region}001'
  location: location
  properties: {
    publicNetworkAccess: 'Disabled'
    sku: {
      family: 'A'
      name: 'premium'
    }
    tenantId: tenantid
  }
}
