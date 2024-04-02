param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'dev'
param prefix string = 'kf'
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: '${environment}'
}

param rts array = [
  'rt-${prefix}-${environment}-${region}-app'
  'rt-${prefix}-${environment}-${region}-sql'
  'rt-PESubnet'
  'rt-${prefix}-${environment}-${region}-dmz'
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

