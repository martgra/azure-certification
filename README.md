# Course notes

## Lab 2 notes.

####TODO: 
Read up on different plans for Azure Webapp, cache and Azure-relay

### 4-step order for creating webapp using CLI
```
az group create --location
az appservice plan create --name --resource-group --sku
az webapp create --name --resource-group --plan
az webap deployment source config --name --resource-group --repo-url --branch master --manual-integration
az group delete --name
```

### Same procedure in Powershell
```
New-AzureRmResourceGroup -Name -Location 
New-AzureRmAppServicePlan -Name  -Location -ResourceGroupName -Tier
New-AzureRmWebApp -Name -Location -AppServicePlan -ResourceGroupName
$PropertiesObject = @{
    repoUrl = "$gitrepo";
    branch = "master";
    isManualIntegration = "true";
}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName myResourceGroup -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force
```
