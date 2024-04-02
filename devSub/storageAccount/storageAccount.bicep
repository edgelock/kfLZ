param location string = resourceGroup().location
param region string = 'eus2'
param environment string = 'dev'
param suffix string = 'cms'
param storageAccountName string = 'st${region}${environment}${suffix}001'

resource flowlogStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    allowBlobPublicAccess: false
  }
}
