# Azure Container Lab - Setup

# Azure Cli Login
# az login

# Azure Container Apps extension 
az extension add --name containerapp --upgrade

# Register namespace
az provider register --namespace Microsoft.App

# Azure Monitor Logs namespace
az provider register --namespace Microsoft.OperationalInsights

# setup persistent parameters
# az config param-persist on