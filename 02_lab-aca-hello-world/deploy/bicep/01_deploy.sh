RESOURCE_GROUP="sample-container-ae-app-rg"
LOCATION="australiaeast"

az group create -g $RESOURCE_GROUP -l $LOCATION

az deployment group create -g $RESOURCE_GROUP -f ./main.bicep