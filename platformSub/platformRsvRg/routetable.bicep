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

resource rsv 'Microsoft.RecoveryServices/vaults@2024-01-01' = {
  name: 'rsv-${prefix}-${environment}-${region}-app-001'
  location: location
  tags: tagValues 
  sku: {
    name: 'Standard'
    
  }
}

