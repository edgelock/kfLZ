param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'prod'
param prefix string = 'kf'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'Kingfisher'
  Department: 'Infrastructure'
  Environment: '${environment}'
  Role: 'Network'
  CreationDate: dateTime
}

param rts array = [
  'rt-${prefix}-${environment}-${region}-app-001'
  'rt-${prefix}-${environment}-${region}-sql-001'
  'rt-PESubnet-001'
  'rt-${prefix}-${environment}-${region}-dmz-001'
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

