# clone the super-api repo and cd into it
git clone https://github.com/gbaeke/super-api.git && cd super-api
 
# checkout the quickguide branch
git checkout quickguide
 
# bring up the app; container build will take some time
# add the --location parameter to allow az containerapp up to 
# create resources in the specified location; otherwise it uses
# the default location used by the Azure CLI
az containerapp up -n super-api --source . --ingress external --target-port 8080 --environment env-aca
 
# list apps; super-api has been added with a new external Fqdn
az containerapp list -g $RG -o table
 
# check ACR in the resource group
az acr list -g $RG -o table
 
# grab the ACR name
ACR=$(az acr list -g $RG | jq .[0].name -r)
 
# list repositories
az acr repository list --name $ACR
 
# more details about the repository
az acr repository show --name $ACR --repository super-api
 
# show tags; az containerapp up uses numbers based on date and time
az acr repository show-tags --name $ACR --repository super-api
 
# make a small change to the code; ensure you are still in the
# root of the cloned repo; instead of Hello from Super API we
# will say Hi from Super API when curl hits the /
sed -i s/Hello/Hi/g cmd/app/main.go
 
# run az containerapp up again; a new container image will be
# built and pushed to ACR and deployed to the container app
az containerapp up -n super-api --source . --ingress external --target-port 8080 --environment env-aca
 
# check the image tags; there are two
az acr repository show-tags --name $ACR --repository super-api
 
# curl the endpoint; should say "Hi from Super API"
curl https://$(az containerapp show -g $RG -n super-api | jq .properties.configuration.ingress.fqdn -r)