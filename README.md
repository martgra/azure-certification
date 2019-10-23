# Course notes
## AZ-203T01
## AZ-203T02

### Lab 2 notes.

#### TODO: 
Read up on different plans for Azure Webapp, cache and Azure-relay

#### 4-step order for creating webapp using CLI
```bash
az group create --location
az appservice plan create --name --resource-group --sku
az webapp create --name --resource-group --plan
az webap deployment source config --name --resource-group --repo-url --branch master --manual-integration
az group delete --name
```

#### Same procedure in Powershell
```powershell
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

#### Possible questions 
- Notifications
- Functions: edit in advanced blablabla editor in the portal
- Example code: is the binding right? Is trigger out; no always in. Bindings in or out
 - Avoid long running functions - split up in functions in many small
 - Make stateless functions
 - Functions must have exactly one trigger.

## AZ-203T03

### Storage theory
- Look at urls:
    - table table.core URI
    - NOSQL table.cosmo URI
    - mystorageaccount.<service>.core.windows.net
- What to choose
    - AZ-203T03: CH 4, 199  : Comaparison table
- Keys:
    - Convert keys to fixed strings, and pad with zero.
- Authorization:
    - You need SAS
        - Blob cointainers
        - File shares
        - Tables
- REST API for TABLE
    - Account
    - Table
    - Entitiy
    - API examples
        - https://myaccount.table.core.windows.net/Tables
        - https://myacconut.table.core.windows.net/Tables('MyTable')
        - https://myaccount.table.core.windows.net/Mytable('')
- Basic query syntax
     - $filter
        - eq, gt, ge, lt, le
     - $select and, not, or
     - $top
     - Special characters to be encoded 
- Table storage: Also NOSQL
- CosmoDB REST API
- Relational DB: Azure SQL server
- Blob storage
    - To store
        - Images
        - Distrubuted sharing
        - Special access: Azure CLI
    - Datalakes
    - Storage account --> Container --> Blob
    - Container must be in lowercase
    - Three container types
        - Blocks blob
        - Append blob
        - Page blob: Random access blob: serves as disk for Azure VMs
    - Move to blob storage
        - AzCopy: CLI-tool for Windows and Linux
        - Azure Storage Data Movement library: .ENEt library for moving Data
        - Azure DataFactory
        - Blobfuse: virutal filesustem 
        - Azure Data Box Disk: Physical SSD
    - Storage types
        - Hot Storage: Frequent, High SLA
        - Cool Storage: Infrequent, Lower SLA
        - Archive: For storage only, Offline: High access cost
    - Questions:
        - How is things gonna be stored; considerations
        - Dimension <COLD --- HOT>
    - Events takes place in BLOB storage
        - creating and deleting 
        - 
    


#### Possible questions
- Rest-API heavy emphasis
- Learn strange REST-API syntax for query
- Table service REST API 
- https://myaccount.table.core.windows.net/Mytable()?$top
    - No wildcard queries
    - 
- Not many questions about SQL-server
- MongoDB 
    - MongoDB: What consistency level is recommended.
    - Syntex connected to MongoDB
    - Manage collection using SDK
    - LINQ syntax LEARN IT!
- Azure SQL 
    - Powershell Is this the correct way to copy db?
    - Entity framework
- BLOBS
    - Blob-events
    - container.CreateIfNotExists();
    - Always Async and await.
    - AzCopy syntax: AzCopy Source:\<source> Dest:\<destination> SourceKey:\<paste from azure> DestKey:\<paste from azure> Pattern:\<pattern>
- No questions
    - Redis Cache
## LAB Notes

1. Part: Portal Setup 
    1. Setup storage services needed
        * Azure Cache for Redis
        * Azure SQL
        * Azue  CosmoDB
        * Azure Storage Account
    2. Make Azure SQL server
    3. Make Cosmos DB 
    4. Make Azure Storage account

