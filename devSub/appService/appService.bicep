param appName string = 'devLifeSpeakWeb'
param location string = resourceGroup().location
param appServicePlanName string = 'devcaeaplan01'
param runtimeStack string = 'DOTNET'
param logAnalyticsWorkspaceId string = '/subscriptions/d8b855c8-2412-4cab-9ce3-927c4dab5523/resourcegroups/prdcaearg01/providers/microsoft.operationalinsights/workspaces/prdcaealaw01'

resource devLifeSpeakWeb 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakWebAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}



// resource devLifeSpeakWebDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
//   scope: devLifeSpeakWeb
//   name: 'devLifeSpeakWeb-Settings'
//   properties: {
//     workspaceId: logAnalyticsWorkspaceId
//     logs: [
//       {
//         category: null
//         categoryGroup: 'allLogs'
//         enabled: true
//         retentionPolicy: {
//           days: 30
//           enabled: true
//         }
//       }
//     ]
//     metrics: [
//       {
//         category: 'AllMetrics'
//         enabled: true
//       }
//     ]
//   }
// }

resource devLifeSpeakWebAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

//Log Analytics Workspace
@description('Tags to add to the resources')
param tags object = {}

@description('Application Insights resource name')
param applicationInsightsName string = 'devLifeSpeakWeb'

@description('Log Analytics resource name')
param logAnalyticsWorkspaceName string = 'devcaealaw01'

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 90
    publicNetworkAccessForIngestion: 'Disabled'
    publicNetworkAccessForQuery: 'Disabled'
  }
}

output applicationInsightsId string = devLifeSpeakWebAppi.id

resource devLifeSpeakSuccessFactorsApi 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakSuccessFactorsApi'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakSuccessFactorsApiAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakSuccessFactorsApiAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakSuccessFactorsApiAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakSSOGateway 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakSSOGateway'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakSSOGatewayAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakSSOGatewayAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakSSOGatewayAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakExampleIdentityProvider 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakExampleIdentityProvider'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakExampleIdentityProviderAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakExampleIdentityProviderAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakExampleIdentityProviderAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakMessages 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakMessages'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakMessagesAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakMessagesAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakMessagesAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakCaptionsApi 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakCaptionsApi'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakCaptionsApiAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakCaptionsApiAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakCaptionsApiAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakVideoProcessing 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakVideoProcessing'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakVideoProcessingAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakVideoProcessingAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakVideoProcessingAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakSearchUtility 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakSearchUtility'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakSearchUtilityAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakSearchUtilityAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakSearchUtilityAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakMessageBuilder 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakMessageBuilder'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakMessageBuilderAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakMessageBuilderAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakMessageBuilderAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakExpertReviewUtility 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakExpertReviewUtility'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakExpertReviewUtilityAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakExpertReviewUtilityAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakExpertReviewUtilityAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakExportPipeline 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakExportPipeline'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakExportPipelineAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakExportPipelineAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakExportPipelineAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakDialyOperationsUtility 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakDialyOperationsUtility'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '6.0'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakDialyOperationsUtilityAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakDialyOperationsUtilityAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakDialyOperationsUtilityAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}

resource devLifeSpeakSendATEEmailNotification 'Microsoft.Web/sites@2021-02-01' = {
  name: 'devLifeSpeakSendATEEmailNotification'
  location: location
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanName
    siteConfig: {
      publicNetworkAccess: 'Disabled'
      appSettings: [
        {
          name: 'WEBSITE_LOAD_USER_PROFILE'
          value: '1'
        },{
          name: 'ASPNETCORE_RUNTIME_VERSION'
          value: '4.8'
        },{
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        },{
          name:'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: devLifeSpeakSendATEEmailNotificationAppi.properties.InstrumentationKey
        }
      ]
      windowsFxVersion: runtimeStack
    }
  }
}

resource devLifeSpeakSendATEEmailNotificationAppi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'devLifeSpeakSendATEEmailNotificationAppi'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Flow_Type: 'Bluefield'
  }
}
