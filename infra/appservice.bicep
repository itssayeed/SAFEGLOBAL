param location string
param projectName string
param appSubnetId string

var planName = '${projectName}-asp'
var webAppName = '${projectName}-app'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: planName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  properties: {
    reserved: true // Linux
  }
}

resource webApp 'Microsoft.Web/sites@2023-01-01' = {
  name: webAppName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      vnetRouteAllEnabled: true
      appSettings: [
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Production'
        }
      ]
    }
    httpsOnly: true
  }
}

resource vnetIntegration 'Microsoft.Web/sites/virtualNetworkConnections@2023-01-01' = {
  name: '${webApp.name}/vnet-integration'
  properties: {
    subnetResourceId: appSubnetId
  }
}

output webAppName string = webApp.name
output webAppPrincipalId string = webApp.identity.principalId
