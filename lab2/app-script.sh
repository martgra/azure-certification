#!/bin/bash

### Example script to make hello-world

# Replace the following URL with a public GitHub repo URL
gitrepo=https://github.com/Azure-Samples/php-docs-hello-world
webappname=mywebapp$RANDOM

# Create a resource group.
az group create --location westeurope --name myResourceGroup
echo Group created

# Create an App Service plan in `FREE` tier.
az appservice plan create --name $webappname --resource-group myResourceGroup --sku FREE
echo App service plan created

# Create a web app.
az webapp create --name $webappname --resource-group myResourceGroup --plan $webappname
echo web-app created

# Deploy code from a public GitHub repository. 
az webapp deployment source config --name $webappname --resource-group myResourceGroup \
--repo-url $gitrepo --branch master --manual-integration
echo Code deployed to webapp


# Copy the result of the following command into a browser to see the web app.
echo http://$webappname.azurewebsites.net
echo this is finished
