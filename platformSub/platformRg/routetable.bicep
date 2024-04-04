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

param rts array = [
  'rt-${prefix}-${environment}-${region}-identity-001'
  'rt-${prefix}-${environment}-${region}-infra-001'
  'rt-PESubnet-001'
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

