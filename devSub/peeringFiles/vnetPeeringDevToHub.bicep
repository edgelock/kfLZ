//Peer from prd to hub
param vNetName string = 'vnet-eus2-dev-data'
param remoteVNetName string = 'vnet-eus2-hub-cms'
param remoteVNetID string = '/subscriptions/78326d70-c78b-41e9-a719-410a5a8bfd38/resourceGroups/rg-eus2-hub-nw/providers/Microsoft.Network/virtualNetworks/vnet-eus2-hub-cms'
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
