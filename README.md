# Lab 2 notes.

### 4-step order for creating webapp
1. az group create --location
2. az appservice plan create --name --resource-group --sku
3. az webapp create --name --resource-group --plan
4. az webap deployment source config --name --resource-group --repo-url --branch master --manual-integration
