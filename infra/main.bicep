targetScope = 'resourceGroup'

param location string = resourceGroup().location
param projectName string = 'SAFEGlobal'

module network './network.bicep' = {
  name: 'network-deployment'
  params: {
    location: location
    projectName: projectName
  }
}

module appservice './appservice.bicep' = {
  name: 'appservice-deployment'
  params: {
    location: location
    projectName: projectName
    appSubnetId: network.outputs.appSubnetId
  }
}
