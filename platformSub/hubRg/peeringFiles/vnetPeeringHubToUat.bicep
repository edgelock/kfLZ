//Peer from prd to hub
param vNetName string = 'vnet-nsmuk-hub-uksouth-001'
param remoteVNetName string = 'vnet-kf-uat-uksouth-001'
param remoteVNetID string = '/subscriptions/eecec588-6d49-45ff-b99c-7e6ef9da2af2/resourceGroups/rg-kf-uat-network-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-kf-uat-uksouth-001'
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
