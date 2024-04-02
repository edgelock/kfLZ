param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'dev'
param prefix string = 'kf'
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: '${environment}'
}
resource qause2netappsn01rt 'Microsoft.Network/routeTables@2022-09-01' = {
  name: 'vnet-${prefix}-${environment}-${region}-001'
  location: location
  tags: tagValues
  properties: {
    routes: [

    ]
  }
}
