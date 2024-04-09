//Peer from prd to hub
param vNetName string = 'vnet-nsmuk-hub-uksouth-001'
param remoteVNetName string = 'vnet-kf-dev-uksouth-001'
param remoteVNetID string = '/subscriptions/e9ca2866-0354-4fea-a31d-81a34a16d724/resourceGroups/rg-kf-dev-network-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-kf-dev-uksouth-001'
param allowGatewayTransit bool = true
param useRemoteGateways bool = false
param allowForwardedTraffic bool = true
param allowVirtualNetworkAccess bool = true

resource vnetPeeringResource 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = {
  name: '${vNetName}/${vNetName}-to-${remoteVNetName}'

  properties: {
    remoteVirtualNetwork: {
      id: remoteVNetID
    }
    allowGatewayTransit: allowGatewayTransit
    useRemoteGateways: useRemoteGateways
    allowForwardedTraffic: allowForwardedTraffic
    allowVirtualNetworkAccess: allowVirtualNetworkAccess
  }
}

output id string = vnetPeeringResource.id
