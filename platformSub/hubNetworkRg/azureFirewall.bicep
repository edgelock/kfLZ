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
param availabilityZones array = [1,2]
param virtualNetworkId string = '/subscriptions/19022fa5-e4d8-4433-bd3c-503455903ca2/resourceGroups/rg-nsmuk-hub-network-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-nsmuk-hub-uksouth-001'
param subnetName string = 'AzureFirewallSubnet'

resource firewallPublicIp 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: 'pip-afw-${prefix}-${environment}-${region}-001'
  zones: availabilityZones
  location: location
  tags: tagValues
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

output id string = firewallPublicIp.id

resource AzureFirewall 'Microsoft.Network/azureFirewalls@2022-09-01' = {
  name: 'afw-${prefix}-${environment}-${region}-001'
  location: location
  tags: tagValues
  zones: availabilityZones
  properties: {
    firewallPolicy: {
      id: afwPolicy.id
    }
    sku: {
      name: 'AZFW_VNet'
       tier: 'Standard'
    }
    ipConfigurations: [
      {
        name: 'config-${prefix}-${environment}-${region}-001'
        properties: {
          subnet: {
            id: '${virtualNetworkId}/subnets/${subnetName}'
          }
          publicIPAddress: {
           id: firewallPublicIp.id
          }
        }
      }
    ]
  }
}

resource afwPolicy 'Microsoft.Network/firewallPolicies@2023-09-01' = {
  name: 'afwp-afw-${prefix}-${environment}-${region}-001'
  location: location
  tags: tagValues
  properties: {

    sku: {
       tier: 'Standard'
    }
  }
}

// resource azfwDiagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
//   scope: AzureFirewall
//   name: 'prdcaeafw01-diagnosticSettings'
//   properties: {
//      workspaceId: '/subscriptions/d8b855c8-2412-4cab-9ce3-927c4dab5523/resourceGroups/prdcaearg01/providers/Microsoft.OperationalInsights/workspaces/prdcaealaw01'
//      logs: [
//         {
//            category: 'AzureFirewallApplicationRule'
//            enabled: true
//         }
//         {
//            category: 'AzureFirewallNetworkRule'
//            enabled: true
//         }
//                  {
//            category: 'AzureFirewallDnsProxy'
//            enabled: true
//         }
//         {
//           category: 'AZFWNetworkRule'
//           enabled: true
//         }
//         {
//           category: 'AZFWApplicationRule'
//           enabled: true
//         }
//         {
//           category: 'AZFWNatRule'
//           enabled: true
//         }
//         {
//           category: 'AZFWThreatIntel'
//           enabled: true
//         }
//         {
//           category: 'AZFWIdpsSignature'
//           enabled: true
//         }
//         {
//           category: 'AZFWDnsQuery'
//           enabled: true
//         }
//         {
//           category: 'AZFWFqdnResolveFailure'
//           enabled: true
//         }
//         {
//           category: 'AZFWFatFlow'
//           enabled: true
//         }
//         {
//           category:'AZFWFlowTrace'
//           enabled: true
//         }
//         {
//           category:'AZFWApplicationRuleAggregation'
//           enabled: true
//         }
//         {
//           category:'AZFWNetworkRuleAggregation'
//           enabled: true
//         }
//         {
//           category:'AZFWNatRuleAggregation'
//           enabled: true
//         }
//      ]
//      metrics: [
//         {
//            category: 'AllMetrics'
//            enabled: true
//         }
//      ]
//   }
// }

