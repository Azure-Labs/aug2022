
## Lab Microservice Application with DAPR

### Introduction

Azure Container Apps provides the foundation for deploying microservices featuring:

Independent scaling, versioning, and upgrades
Service discovery
Native Dapr integration

A Container Apps environment provides a security boundary around a group of container apps. A single container app typically represents a microservice, which is composed of container apps made up of one or more containers.

Dapr integration

When implementing a system composed of microservices, function calls are spread across the network. To support the distributed nature of microservices, you need to account for failures, retries, and timeouts. While Container Apps features the building blocks for running microservices, use of Dapr provides an even richer microservices programming model. Dapr includes features like observability, pub/sub, and service-to-service invocation with mutual TLS, retries, and more


### Context

Now that you successfully deployed a simple application, let’s see how Azure Container Apps could help with more complex applications. You are going to deploy a full micro-services application named Red Dog. Microservice architectures allow you to independently develop, upgrade, version, and scale core areas of functionality in an overall system. Azure Container Apps provides the foundation for deploying microservices featuring:

- Independent scaling, versioning, and upgrades
- Service discovery
- Native Dapr integration

A Container Apps environment provides a security boundary around a group of container apps. A single container app typically represents a microservice, which is composed of container apps made up of one or more containers.


### Dapr integration
When implementing a system composed of microservices, function calls are spread across the network. To support the distributed nature of microservices, you need to account for failures, retries, and timeouts. While Container Apps features the building blocks for running microservices, use of Dapr provides an even richer microservices programming model. Dapr includes features like observability, pub/sub, and service-to-service invocation with mutual TLS, retries, and more.

Dapr is a CNCF project that helps developers overcome the inherent challenges presented by distributed applications, such as state management and service invocation. Container Apps also provides a fully-managed integration with the Kubernetes Event Driven Autoscaler (KEDA). KEDA allows your containers to autoscale based on incoming events from external services such Azure Service Bus or Redis.

For more information on using Dapr, see Build microservices with Dapr.


### Steps

** Run setup.sh to setup extensions required

Azure Bicep 

1. Open /deploy/cli/01_deploy_initial.sh. Replace subscription id
2. Run az login for subscription access
3. Run /deploy/cli/01_deploy_initial.sh

Review the deployment on Azure portal

![Application](https://raw.githubusercontent.com/Azure-Samples/container-apps-store-api-microservice/main/assets/arch.png)


## Fork
https://github.com/Azure-Samples/container-apps-store-api-microservice
https://github.com/willvelida/reddog-containerapps
https://docs.microsoft.com/en-gb/azure/container-apps/samples