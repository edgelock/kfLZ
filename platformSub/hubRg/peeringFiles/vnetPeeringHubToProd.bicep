//Peer from prd to hub
param vNetName string = 'vnet-nsmuk-hub-uksouth-001'
param remoteVNetName string = 'vnet-kf-prod-uksouth-001'
param remoteVNetID string = '/subscriptions/598edc91-689f-49a5-9ccc-0bc3167d918f/resourceGroups/rg-kf-prod-network-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-kf-prod-uksouth-001'
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
