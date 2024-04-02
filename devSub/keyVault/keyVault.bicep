param location string = resourceGroup().location
param tenantId string = '2fb36de5-296a-43c7-b5d2-ae73931f0aa3'
param region string = 'eus2'
param environment string = 'dev'
param suffix string = 'cms'

resource prdKeyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  location: location
  name: 'kv-${region}-${environment}-${suffix}'
  
  properties: {
    sku: {
      family: 'A'
      name: 'premium'
    }
    tenantId: tenantId
    publicNetworkAccess: 'Disabled'
    enableRbacAuthorization: true
  }
}
