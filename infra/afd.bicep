param afdProfileName string
param gatewayHostName string

// Azure Front Door Profile
resource afdProfile 'Microsoft.Cdn/profiles@2023-05-01' = {
  name: afdProfileName
  location: 'global'
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
}

// Front Door Endpoint (public DNS)
resource afdEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2023-05-01' = {
  parent: afdProfile
  name: 'safeglobal-endpoint'
  location: 'global'
  properties: {
    enabledState: 'Enabled'
  }
}

// Origin Group (represents YARP Gateway backend)
resource originGroup 'Microsoft.Cdn/profiles/originGroups@2023-05-01' = {
  parent: afdProfile
  name: 'gateway-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
    }
    healthProbeSettings: {
      probePath: '/'
      probeProtocol: 'Https'
      probeIntervalInSeconds: 60
    }
  }
}

// Origin (YARP Gateway)
resource origin 'Microsoft.Cdn/profiles/originGroups/origins@2023-05-01' = {
  parent: originGroup
  name: 'yarp-gateway-origin'
  properties: {
    hostName: gatewayHostName
    httpsPort: 443
    priority: 1
    weight: 1000
  }
}

// Route configuration
resource route 'Microsoft.Cdn/profiles/routes@2023-05-01' = {
  parent: afdProfile
  name: 'gateway-route'
  properties: {
    endpointName: afdEndpoint.name
    originGroup: {
      id: originGroup.id
    }
    supportedProtocols: [
      'Https'
    ]
    patternsToMatch: [
      '/mortgages/*'
      '/loans/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToDefaultDomain: 'Enabled'
    httpsRedirect: 'Enabled'
  }
}
