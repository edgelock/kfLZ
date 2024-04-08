@description('The Azure region where the Bastion should be deployed')
param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'hub'
param prefix string = 'nsmuk'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'NSM UK'
  Department: 'Infrastructure'
  Environment: '${environment}'
  Role: 'Network'
  CreationDate: dateTime

}

param virtualNetworkId string = '/subscriptions/d8b855c8-2412-4cab-9ce3-927c4dab5523/resourceGroups/prdcaearg01/providers/Microsoft.Network/virtualNetworks/hubcaeanet01'
param subnetName string = 'AzureBastionSubnet'


@description('The name of the Bastion public IP address')
param publicIpName string = 'devcaeabastionpip'

@description('The name of the Bastion host')
param bastionHostName string = 'BastionHost'

@description('The ID of LAW')
param logAwsID string = '/subscriptions/d8b855c8-2412-4cab-9ce3-927c4dab5523/resourcegroups/prdcaearg01/providers/microsoft.operationalinsights/workspaces/prdcaealaw01'


resource publicIpAddressForBastion 'Microsoft.Network/publicIPAddresses@2022-01-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource bastionHost 'Microsoft.Network/bastionHosts@2021-05-01' = {
  name: bastionHostName
  location: location
  properties: {
    ipConfigurations: [
      {
      name: 'IpConfig1'
      properties: {
        publicIPAddress: {
          id: publicIpAddressForBastion.id
        }
        subnet: {
          id: '${virtualNetworkId}/subnets/${subnetName}'
        }
      }
      }
    ]
  }
}

resource bastionDiagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
  scope: bastionHost
  name: '${bastionHostName}-diagnosticSettings'
  properties: {
    workspaceId: logAwsID
    logs: [
      {
        category: 'BastionAuditLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}


