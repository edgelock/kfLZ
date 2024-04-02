param location string = resourceGroup().location
param region string = 'eus2'
param environment string = 'dev'
param suffix string = 'cms'
param dataFactoryName string = 'adf-${region}-${environment}-${suffix}'

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}
