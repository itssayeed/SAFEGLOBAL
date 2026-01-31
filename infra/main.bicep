targetScope = 'resourceGroup'

@description('App Service Plan name')
param appServicePlanName string = 'safeglobal-asp'

@description('Gateway Web App name')
param webAppName string = 'safeglobal-gateway'

@description('Azure region')
param location string = 'southindia'

// App Service Plan (Windows)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    capacity: 1
  }
  kind: 'app'
  properties: {
    reserved: false // Windows
  }
}

// Web App for YARP Gateway
resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      netFrameworkVersion: 'v8.0'
      alwaysOn: true
    }
    httpsOnly: true
  }
}
