param location string = resourceGroup().location
param tenantId string = '2fb36de5-296a-43c7-b5d2-ae73931f0aa3'
param region string = 'eus2'
param environment string = 'dev'
param suffix string = 'cms'
resource qause2netappsn01rt 'Microsoft.Network/routeTables@2022-09-01' = {
  name: 'rt-${region}-${environment}-${suffix}'
  location: location
  properties: {
    routes: [
      {
        name: 'toOnPrem1'
        properties: {
          nextHopType: 'VirtualNetworkGateway'
          addressPrefix: '10.6.0.0/16'
        }
      }
      {
        name: 'toOnPrem2'
        properties: {
          nextHopType: 'VirtualNetworkGateway'
          addressPrefix: '168.190.121.0/24'
        }
      }
    ]
  }
}
