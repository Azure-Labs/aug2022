param image string = 'ghcr.io/gbaeke/super:1.0.5'

resource la 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'la-aca' 
  location: resourceGroup().location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource env 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: 'container-sample-env'
  location: resourceGroup().location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: la.properties.customerId
        sharedKey: la.listKeys().primarySharedKey
      }
    }
  }
}


resource containerApp 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'my-container-app'
  location: resourceGroup().location
  properties: {
    managedEnvironmentId: env.id
    configuration: {
      activeRevisionsMode: 'Multiple'
      ingress:  {
        external: true
        targetPort: 8080
        transport: 'auto'
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
          /*{
              revisionName: 'front--rev1'
              weight: 80
          }
          {
              latestRevision: true
              weight: 20
          } */     
        ]
      } 
    }
    template: {
      revisionSuffix: 'rev1'
      containers: [
        {
          image: image
          name: 'super'
            env: [
              {
                name: 'WELCOME'
                value: 'Welcome to Container Apps 1'
              }
            ]
        }
      ]
      scale: {
        minReplicas: 0
        maxReplicas: 5
          rules: [
            {
            name: 'http-rule'
            http: {
              metadata: {
                concurrentRequests: '5'
              }
            }
            }
          ]        
      }
    }
  }
}
