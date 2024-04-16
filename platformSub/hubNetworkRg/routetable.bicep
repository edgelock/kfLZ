param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'hub'
param prefix string = 'nsmuk'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: environment
  Role: 'Network'
  CreationDate: dateTime
}

param rts array = [
  'rt-${prefix}-${environment}-${region}-external-001'
  'rt-${prefix}-${environment}-${region}-internal-001'
  'rt-PESubnet-${prefix}-${environment}-${region}-001'
  'rt-GatewaySubnet-${prefix}-${environment}-${region}-001'
  'rt-AzureFirewallSubnet-${prefix}-${environment}-${region}-001'
  'rt-AzureBastionSubnet-${prefix}-${environment}-${region}-001'
]


resource listOfRt 'Microsoft.Network/routeTables@2023-09-01' = [for rt in rts:{
  name: rt
  location: location
  tags: tagValues
  properties: {
    routes: [
      
    ]
  }
} ]

