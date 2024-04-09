//Peer from prd to hub
param vNetName string = 'vnet-nsmuk-hub-uksouth-001'
param remoteVNetName string = 'vnet-nsmuk-platform-uksouth-001'
param remoteVNetID string = '/subscriptions/19022fa5-e4d8-4433-bd3c-503455903ca2/resourceGroups/rg-nsmuk-platform-network-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-nsmuk-platform-uksouth-001'
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
