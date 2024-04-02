param appName string = 'devcaeaplan01'
param location string = resourceGroup().location
param sku string = 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appName
  location: location
  sku: {
    name: sku
    capacity: 1
  }
}
