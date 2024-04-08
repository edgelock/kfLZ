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

param virtualNetworkId string = '/subscriptions/19022fa5-e4d8-4433-bd3c-503455903ca2/resourceGroups/rg-nsmuk-hub-network-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-nsmuk-hub-uksouth-001'
param subnetName string = 'AzureBastionSubnet'


@description('The name of the Bastion public IP address')
param publicIpName string = 'pip-${prefix}-${environment}-${region}-001'

@description('The name of the Bastion host')
param bastionHostName string = 'BastionHost'

@description('The ID of LAW')
param logAwsID string = '/subscriptions/19022fa5-e4d8-4433-bd3c-503455903ca2/resourcegroups/rg-nsmuk-hub-mgmt-uksouth-001/providers/microsoft.operationalinsights/workspaces/law-nsmuk-hub-uksouth-001'


resource publicIpAddressForBastion 'Microsoft.Network/publicIPAddresses@2022-01-01' = {
  name: publicIpName
  location: location
  tags: tagValues
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
  tags: tagValues
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


