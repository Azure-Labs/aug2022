RESOURCE_GROUP="sample-container-ae-app-rg"
LOCATION="australiaeast" #ensure the location supports container app service
LOG_ANALYTICS_WORKSPACE="sample-container-logs"
SUB_ID="<subscription_id>"
CONTAINERAPPS_ENVIRONMENT="container-sample-env"

az group delete --name $RESOURCE_GROUP --yes
