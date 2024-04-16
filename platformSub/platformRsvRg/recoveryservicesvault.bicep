param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'platform'
param prefix string = 'nsmuk'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: '${environment}'
  Role: 'Management'
  CreationDate: dateTime
}

resource rsv 'Microsoft.RecoveryServices/vaults@2024-01-01' = {
  name: 'rsv-${prefix}-${environment}-${region}-001'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Disabled'
    securitySettings: {
       softDeleteSettings: {
         softDeleteRetentionPeriodInDays: '100'
         enhancedSecurityState: 'AlwaysON'
       }
    }
  }
}

