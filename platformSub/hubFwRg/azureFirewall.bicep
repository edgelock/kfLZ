param location string = resourceGroup().location
param region string = 'uksouth'
param environment string = 'uat'
param prefix string = 'kf'
param dateTime string = utcNow('d')
param tagValues object = {
  Company: 'Kingfisher'
  Department: 'Infrastructure'
  Environment: '${environment}'
  Role: 'Networking'
  CreationDate: dateTime
}
param virtualNetworkId string = '/subscriptions/ccac80e3-7745-4704-b3d9-b4e013715469/resourceGroups/hubuse2rg/providers/Microsoft.Network/virtualNetworks/hub-use2-net-vnet01'
param subnetName string = 'AzureFirewallSubnet'

resource firewallPublicIp 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: 'hubuse2fwpip01'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

output id string = firewallPublicIp.id



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

