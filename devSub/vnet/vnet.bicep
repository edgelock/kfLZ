param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'dev'
param prefix string = 'kf'

var subnets = [
  {
    name: 'snet-${prefix}-${environment}-${region}-app-001'
    subnetPrefix: '10.150.12.0/27'
  }
  {
    name: 'snet-${prefix}-${environment}-${region}-sql-001'
    subnetPrefix: '10.150.12.32/27'
  }
  {
    name: 'PESubnet'
    subnetPrefix: '10.150.12.64/27'
  }
  {
    name: 'snet-${prefix}-${environment}-${region}-dmz-001'
    subnetPrefix: '10.150.12.96/27'
  }
]


resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: 'vnet-${prefix}-${environment}-${region}-001'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.150.12.0/22'
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
    name: 'nsg-${prefix}-${environment}-${region}-app-001'
  }
  {
    name: 'nsg-${prefix}-${environment}-${region}-sql-001'
  }
  {
    name: 'nsg-PESubnet'
  }
  {
    name: 'nsg-${prefix}-${environment}-${region}-dmz-001'
  }

]

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = [for nsgs in nsgs: {
  name: nsgs.name
  location: location
  properties: {
    securityRules: []
  }   
}]
