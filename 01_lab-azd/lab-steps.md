
## Lab 01 - Azure Developer CLI

The Azure Developer CLI (azd) Preview is a developer-centric command-line tool for building cloud apps. The azd is a set of commands that allows you to work consistently across azd templates, DevOps workflows, and your IDE (integrated development environment).

Reference:
https://docs.microsoft.com/en-us/azure/developer/azure-developer-cli/overview?tabs=nodejs
Additional Document example and lab. Thought https://github.com/adamstephensen/faqs/blob/master/azure-demo-scripts/azure-developer-cli.md

### What is AZD?

>The Azure Developer CLI (azd) Preview is a developer-centric command-line tool for building cloud apps. The azd is a set of commands that allows you to work consistently across azd templates, DevOps workflows, and your IDE (integrated development environment).
- Officlial Documentation: https://docs.microsoft.com/en-us/azure/developer/azure-developer-cli/overview

- Azure Developer CLI focuses on enabling the developers with a easy to use CLI interface which does the end to end deployment of their source code. 
- Currently AZD is in beta and you can find the list of releases here: https://github.com/Azure/azure-dev/releases
- There's support for multiple environments. 
- Not intended for Production, even after being generally avaialble, it never should be. 
- Currently in Preview. 
> `0.1.0-beta.5`

-----
**What Problem's will this solve for you?**

- You're effectively empowering the developers to bypass some of the hurdles of waiting for IT/Ops. 
- Make the development teams efficent, test out changes much faster. 

### Current support matrix: 

Services:
- Azure App Services
- Azure Functions 
- Azure Cotainer Apps
- Azure Static Web Apps
- Azure Kubernetes Service (Coming Soon)

Languages: 
- Node.js
- Python
- .NET
- Java (Coming Soon)

IaC:

- bicep.
- terraform (Coming Soon, v0.2 likely)
	- https://github.com/Azure/azure-dev/issues/658
	- Lots of 404s, likely some private repositories in play

--------
### Where to start looking?

GitHub - https://github.com/Azure/azure-dev

------

### Installer Types
- Binary
- All encompassing docker container
- Extra: VSCode Extension
- Codespaces (Coming Soon)


### Installation

#### Prerequsites

-   [Git](https://git-scm.com/)
-   [GitHub CLI v2.13+](https://github.com/cli/cli)
-   [Azure CLI (v 2.38.0+)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

#### Windows

```
powershell -ex AllSigned -c "Invoke-RestMethod 'https://aka.ms/install-azd.ps1' | Invoke-Expression"
```

#### Linux/MacOS

```
curl -fsSL https://aka.ms/install-azd.sh | bash
```

### Uninstall Azure Developer CLI

#### Windows

```powershell
powershell -ex AllSigned -c "Invoke-RestMethod 'https://aka.ms/uninstall-azd.ps1' | Invoke-Expression"
```

#### Linux/MacOS

```bash
curl -fsSL https://aka.ms/uninstall-azd.sh | bash
```

#### Docker Container

##### Official

```bash
docker run -w /root/source -it -v /var/run/docker.sock:/var/run/docker.sock mcr.microsoft.com/azure-dev-cli-apps:latest
```

##### Customised

```bash
docker run -w /root/source -it -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/venura9/azd:main zsh
```

Why? Size and Control

```bash
REPOSITORY                                 TAG       IMAGE ID       CREATED        SIZE
ghcr.io/venura9/azd                        main      2e149efcd988   32 hours ago   1.25GB
mcr.microsoft.com/azure-dev-cli-apps       latest    3828387c7e73   2 weeks ago    2.76GB
```

Dockerfile

Note: I couldn't get everything working with the `alpine` base container image, likely some missing dependancies. If you have got it working don't forget to send though a pull request to: https://github.com/venura9/azd

```dockerfile
ARG AZURE_CLI_VERSION="2.39.0"
FROM mcr.microsoft.com/azure-cli:${AZURE_CLI_VERSION}
ARG GH_CLI_VERSION="2.14.4"

# Install Dependancies
RUN apk add zsh figlet vim docker

# Install GitHub CLI
RUN curl -O -L https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
tar -zxvf gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
chmod +x gh_${GH_CLI_VERSION}_linux_amd64/bin/gh && \
mv gh_${GH_CLI_VERSION}_linux_amd64/bin/* /usr/bin && \
mv gh_${GH_CLI_VERSION}_linux_amd64/share/* /usr/share/ && \
rm -rf gh_${GH_CLI_VERSION}_linux_amd64*

# Install azd
ARG AZD_VERSION="0.1.0-beta.5"
RUN curl -O -L https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_${AZD_VERSION}/azd-linux-amd64.tar.gz && \
tar -xvzf azd-linux-amd64.tar.gz && \
chmod +x azd-linux-amd64 && \
mv azd-linux-amd64 /usr/bin/azd && \
rm -rf azd-linux-amd64*
# RUN sh -c "$(curl -fsSL https://aka.ms/install-azd.sh)"

# Install ohmyzsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set zsh as default shell
# `/etc/profile` logic did't like it when zsh was default.
RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# Welcome Text
RUN echo -e "\nfiglet 'AZ Dev CLI'\necho 'https://github.com/venura9/azd'\n" >> ~/.bashrc && \
echo -e "\nfiglet 'AZ Dev CLI'\necho 'https://github.com/venura9/azd'\n" >> ~/.zshrc
```

Dev Container

```bash
# MacOs
git clone https://github.com/venura9/azd.git
cd azd
code .
```

Source: https://github.com/venura9/azd

### Deploy a sample and Inspect

Lets explore the `azd` itself first and deploy a sample application. 

```

Available Commands:
  deploy      Deploy the application's code to Azure.
  down        Delete Azure resources for an application.
  env         Manage environments.
  help        Help about any command
  infra       Manage Azure resources.
  init        Initialize a new application.
  login       Log in to Azure.
  monitor     Monitor a deployed application.
  pipeline    Manage GitHub Actions pipelines.
  provision   Provision the Azure resources for an application.
  restore     Restore application dependencies.
  template    Manage templates.
  up          Initialize application, provision Azure resources, and deploy your project with a single command.
  version     Print the version number of Azure Developer CLI.
```

With the Azure Developer CLI, a typical developer workflow looks like this:

1.  `azd init`: Create an application and initialize an environment using a sample template in your preferred language.
2.  `azd provision`: Provision the necessary resources for your application on Azure.
3.  `azd deploy`: Deploy your application to Azure.
4.  `azd monitor`: Monitor your application’s behavior and performance and validate deployments.
5.  `azd pipeline config`: Create and manage CI/CD (continuous integration and continuous delivery).

````bash

# Ceate the infra and deploy the application inteactively 
azd up --template todo-nodejs-mongo-aca

# Destroy the infrastrcture
azd down
````


```


### Creating your own template: 

```txt
├── .devcontainer              [ For DevContainer ]
├── .github                    [ Configure GitHub workflow ]
├── .vscode                    [ VS Code workspace ]
├── assets                     [ Assets used by README.MD ]
├── infra                      [ Creates and configures Azure resources ]
│   ├── main.bicep             [ Main infrastructure file ]
│   ├── main.parameters.json   [ Parameters file ]
│   └── resources.bicep        [ Resources file ]
├── src                        [ Contains directories for the app code ]
└── azure.yaml                 [ Describes the app and type of Azure resources]
```


Create the empty project. 

```bash
azd init -e dev -l australiaeast --subscription <subscription_id/name>
```

Use empty template

```
? Select a project template  [Use arrows to move, type to filter]
> Empty Template
  Azure-Samples/todo-python-mongo-swa-func
  Azure-Samples/todo-nodejs-mongo
  Azure-Samples/todo-python-mongo
  Azure-Samples/todo-csharp-cosmos-sql
  Azure-Samples/todo-nodejs-mongo-aca
  Azure-Samples/todo-python-mongo-aca
```

Update your `azure.yaml`

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/Azure/azure-dev/main/schemas/v1.0/azure.yaml.json

name: aca-example
services:
  app:
    project: src
    language: js
    host: containerapp
```

Create the infra folder
``` bash
mkdir infra && cd infra
```

You infra as code

Parameters: 

`main.parameters.json`

```main.parameters.json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
      "name": {
        "value": "${AZURE_ENV_NAME}"
      },
      "location": {
        "value": "${AZURE_LOCATION}"
      },
      "image": {
        "value": ""
      }
    }
  }
```



`main.bicep`

```main.bicep
targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param name string

@minLength(1)
@description('Primary location for all resources')
param location string

@description('Container image to be deployed')
param image string


var resourceToken = toLower(uniqueString(subscription().id, name, location))

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${name}'
  location: location
}

module app 'app.bicep' = {
  name: 'app'
  scope: rg
  params: {
    appName: name
    environmentName: resourceToken
    appId: name
    location: location
    image: image
  }
}

output AZURE_CONTAINER_REGISTRY_ENDPOINT string = app.outputs.AZURE_CONTAINER_REGISTRY_ENDPOINT
output AZURE_CONTAINER_REGISTRY_NAME string = app.outputs.AZURE_CONTAINER_REGISTRY_NAME
output AZURE_APP_NAME string = name
output AZURE_APP_ENV_NAME string = resourceToken
```


`app.parameters.json`

```app.parameters.json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
      "environmentName": {
        "value": "${AZURE_APP_ENV_NAME}"
      },
      "appName": {
        "value": "${AZURE_APP_NAME}"
      },
      "appId": {
        "value": "${AZURE_APP_NAME}"
      },
      "image": {
        "value": "${SERVICE_APP_IMAGE_NAME}"
      }
    }
}
```

`app.bicep`

```app.bicep
param environmentName string
param image string
param appName string
param appId string
param logAnalyticsWorkspaceName string = 'logs-${environmentName}'
param appInsightsName string = 'appins-${environmentName}'
param location string = resourceGroup().location

var tags = { 'azd-env-name': 'app' }

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId:logAnalyticsWorkspace.id
  }
}

// https://github.com/Azure/azure-rest-api-specs/blob/Microsoft.App-2022-03-01/specification/app/resource-manager/Microsoft.App/preview/2022-01-01-preview/ManagedEnvironments.json
resource environment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: 'me-${environmentName}'
  location: location
  properties: {
    daprAIInstrumentationKey:appInsights.properties.InstrumentationKey
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspace.properties.customerId
        sharedKey: logAnalyticsWorkspace.listKeys().primarySharedKey
      }
    }
  }
  resource daprComponent 'daprComponents@2022-03-01' = {
    name: 'mycomponent'
    properties: {
      componentType: 'state.azure.cosmosdb'
      version: 'v1'
      ignoreErrors: true
      initTimeout: '5s'
      secrets: [
        {
          name: 'masterkeysecret'
          value: 'secretvalue'
        }
      ]
      metadata: [
        {
          name: 'masterkey'
          secretRef: 'masterkeysecret'
        }
        {
          name: 'foo'
          value: 'bar'
        }
      ]
      scopes:[
        appId
      ]
    }
  }
}

// https://github.com/Azure/azure-rest-api-specs/blob/Microsoft.App-2022-01-01-preview/specification/app/resource-manager/Microsoft.App/preview/2022-01-01-preview/ContainerApps.json
resource app 'Microsoft.App/containerApps@2022-03-01' ={
  tags: tags
  name: 'devapp'
  location: location
  properties:{
    managedEnvironmentId: environment.id
    configuration: {
      ingress: {
        targetPort: 3000
        external: true
      }
      dapr: {
        enabled: true
        appId: appId
        appProtocol: 'http'
        appPort: 80
      }
      secrets: [
        {
          name: 'registry-password'
          value: containerRegistry.listCredentials().passwords[0].value
        }
      ]
      registries: [
        {
          server: '${containerRegistry.name}.azurecr.io'
          username: containerRegistry.name
          passwordSecretRef: 'registry-password'
        }
      ]
    }
    template: {
      containers: [
        {
          image: image != '' ? image : 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
          name: 'app'
          env: [
            {
                name: 'HTTP_PORT'
                value: '3000'
            }
        ]
        }
      ]
    }
  }
}


// 2022-02-01-preview needed for anonymousPullEnabled
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  name: 'cr${environmentName}'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    adminUserEnabled: true
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    encryption: {
      status: 'disabled'
    }
    networkRuleBypassOptions: 'AzureServices'
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
  }
}

output AZURE_CONTAINER_REGISTRY_ENDPOINT string = containerRegistry.properties.loginServer
output AZURE_CONTAINER_REGISTRY_NAME string = containerRegistry.name

```


Express App

```bash
npx express-generator src --view ejs
```


