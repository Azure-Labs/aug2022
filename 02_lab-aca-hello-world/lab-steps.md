
## LAB ACA Hello World

Azure Container Apps is now generally available. Time for a quick guide

### Pre-requisites

All commands are run from bash in WSL 2 (Windows Subsystem for Linux 2 on Windows 11)
- Azure CLI and logged in to an Azure subscription with an Owner role (use az login)
- ACA extension for Azure CLI: az extension add --name containerapp --upgrade
- Microsoft.App namespace registered: az provider register --namespace Microsoft.App; this namespace is used since March
- If you have never used Log Analytics, also register Microsoft.OperationalInsights: az provider register --namespace Microsoft.OperationalInsights

### Outcome

Deploy an initial basic application and review how revisions work

![Revisions](https://docs.microsoft.com/en-us/azure/container-apps/media/revisions/azure-container-apps-revisions.png)

- The first revision is automatically created when you deploy your container app.
- New revisions are automatically created when you make a revision-scope change to your container app.
- While revisions are immutable, they're affected by application-scope changes, which apply to all revisions.
- You can retain up to 100 revisions, giving you a historical record of your container app updates.
- You can run multiple revisions concurrently.
- You can split external HTTP traffic between active revisions.

You can use revisions to:

- Release a new version of your app.
- Quickly revert to an earlier version of your app.
- Split traffic between revisions for A/B testing.
- Gradually phase in a new revision in blue-green deployments. For more information about blue-green deployment, see BlueGreenDeployment.

![Traffic Split](https://docs.microsoft.com/en-us/azure/container-apps/media/revisions/azure-container-apps-revisions-traffic-split.png)

#### Revision-scope changes

A new revision is created when a container app is updated with revision-scope changes. The changes are limited to the revision in which they're deployed, and don't affect other revisions.

A revision-scope change is any change to the parameters in the properties.template section of the container app resource template.

These parameters include:

- Revision suffix
- Container configuration and images
- Scale rules for the container application

Include the following changes

revisionSuffix	A friendly name for a revision. This value must be unique as the runtime rejects any conflicts with existing revision name suffix values.	string
containers	Configuration object that defines what container images are included in the container app.	object
scale	Configuration object that defines scale rules for the container app.	object

#### Application-scope changes

When you deploy a container app with application-scope changes:

The changes are globally applied to all revisions.
A new revision isn't created.
Application-scope changes are defined as any change to the parameters in the properties.configuration section of the container app resource template.

These parameters include:

- Secret values (revisions must be restarted before a container recognizes new secret values)
- Revision mode
Ingress configuration including:
- Turning ingress on or off
- Traffic splitting rules
- Labels
- Credentials for private container registries
- Dapr settings

https://docs.microsoft.com/en-us/azure/container-apps/revisions

### Steps

Azure CLI 

1. Open /deploy/cli/01_deploy_initial.sh. Replace subscription id
2. Run az login for subscription access
3. Run /deploy/cli/01_deploy_initial.sh

Review the deployment on Azure portal

Lets now deploy a revision to container 2

4. Open /deploy/cli/02_deploy_revision.sh. Replace subscription id
5. 02_deploy_revision.sh

TODO
Update Revision - Better example for revision https://gist.github.com/gbaeke/8b3ec20da98c6d579e0ac43113d1853e
Update Bicep example and deployment
Update persistent params