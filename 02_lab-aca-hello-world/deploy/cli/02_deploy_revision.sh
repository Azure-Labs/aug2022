# LAB 02 - ACA Hello World

RESOURCE_GROUP="sample-container-simple-ae-app-rg"
LOCATION="australiaeast" #ensure the location supports container app service
LOG_ANALYTICS_WORKSPACE="sample-container-logs"
CONTAINERAPPS_ENVIRONMENT="container-sample-env"

# deploy hello-world with ingress external. Image latest hello-world
echo "Deploy new revision for first container app"
az containerapp update \
  --name my-container-app \
  --resource-group $RESOURCE_GROUP \
  --image mavilleg/acarevision-helloworld:acarevision-hellowold \
  --revision-suffix 'rev2' \
  --query configuration.ingress.fqdn

  echo "Deploy new revision 2nd container app - Multiple revision"
az containerapp update \
  --name my-container-app-2 \
  --resource-group $RESOURCE_GROUP \
  --image mavilleg/acarevision-helloworld:acarevision-hellowold \
  --revision-suffix 'rev2' \
  --query configuration.ingress.fqdn

az containerapp revision label add --name my-container-app-2 --resource-group $RESOURCE_GROUP --label 'staging' --revision 'my-container-app-2--rev2' --no-prompt --yes 

echo "Set traffic split"
az containerapp ingress traffic set \
  --name my-container-app-2 \
  --resource-group $RESOURCE_GROUP \
  --revision-weight latest=50 my-container-app-2--rev2=50