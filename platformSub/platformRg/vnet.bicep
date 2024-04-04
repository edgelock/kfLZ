param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'platform'
param prefix string = 'nsmuk'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: '${environment}'
  Role: 'Network'
  CreationDate: dateTime
}

var subnets = [
  {
    name: 'snet-${prefix}-${environment}-${region}-identity-001'
    subnetPrefix: '10.150.4.0/27'
  }
  {
    name: 'snet-${prefix}-${environment}-${region}-infra-001'
    subnetPrefix: '10.150.4.32/27'
  }
  {
    name: 'PESubnet'
    subnetPrefix: '10.150.4.64/27'
  }
]


resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: 'vnet-${prefix}-${environment}-${region}-001'
  location: location
  tags: tagValues
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.150.4.0/22'
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
    name: 'nsg-${prefix}-${environment}-${region}-identity-001'
  }
  {
    name: 'nsg-${prefix}-${environment}-${region}-infra-001'
  }
  {
    name: 'nsg-PESubnet-001'
  }

]

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = [for nsgs in nsgs: {
  name: nsgs.name
  location: location
  tags: tagValues
  properties: {
    securityRules: []
  }   
}]
