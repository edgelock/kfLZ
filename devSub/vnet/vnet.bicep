param location string = resourceGroup().location
param tenantId string = '2fb36de5-296a-43c7-b5d2-ae73931f0aa3'
param region string = 'eus2'
param environment string = 'dev'
param suffix string = 'data'
var subnets = [
  {
    name: 'snet-${region}-${environment}-${suffix}-pe'
    subnetPrefix: '10.5.8.0/27'
  }
  {
    name: 'snet-${region}-${environment}-${suffix}-mgmt'
    subnetPrefix: '10.5.8.32/27'
  }
]


resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: 'vnet-${region}-${environment}-${suffix}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.5.8.0/24'
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.subnetPrefix
      }
    }]
  }
}

var nsgs = [
  {
    name: 'nsg-${region}-${environment}-${suffix}-pe'
  }
  {
    name: 'nsg-${region}-${environment}-${suffix}-mgmt'
  }

]

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = [for nsgs in nsgs: {
  name: nsgs.name
  location: location
  properties: {
    securityRules: []
  }   
}]
