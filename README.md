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
### LAB Notes

1. Part: Portal Setup 
    1. Setup storage services needed
        * Azure Cache for Redis
        * Azure SQL
        * Azue  CosmoDB
        * Azure Storage Account
    2. Make Azure SQL server
    3. Make Cosmos DB 
    4. Make Azure Storage account


## AZ-203T04
1. Multitenant app
    - common endpoint where people login
    - 
2. Types of permissions
    - Delegated permission
    - Application permission
3. Type of consent
    - Static user consent: Automatic via OAuth2
    - Dynamic user consent: Users will be prompted
4. Type of authentication
    - Legacy authentication: Formbased in HTML
    - Kerberos
    - ASP.NET Identity
    - App Authentication
    - Multifactor: New way
        - Knowledge: pw
        - Possession: token
        - Inherence: biometic
    - Multifactor with Azure AD
        - Two factor: call, text, notification through mobilde app, verification code from mobile app

### Implement Access control
1. RBAC - role based access control
    - Grant access to specific resources
    - Best practise: Segregate duties: Reader, contributer, owener
    - Security principal:
        - User: profile in AD
        - Group of user in AD
        - Service principal: Security identity: For application, rather than people
        - Managed Identity: Azure automatically manages
    - Role definition in JSON files
    - Roles:
        - Owner Full access, grant others access
        - Contribuer: Create an manage all type of services
        - Reader: Can view
    - Role assignment
        - Attach role definition to a user. 
        - Portal, CLI, APIS, SDK, PS1
        - Must have MS.Authorization/roleAssignment/*Access Administrator roles
    - Supports Deny:
        - Deny will override any allow on any higher level.
    - Classic admin roles
        - 
2. Encryption
    - End to end encryption
    - TDE: SQL Server, A SQL Database and Azure SQL Data Warehouse    
    - Always encrypted feature
3. Confidential computing
    - High level of compute - at the same time high level of encryption
    - Trusted Execution Environment (TEE). 
    - Cannot debug the object remote or interal
    - Altering disables compute
4. Manage keys through Vauls
    - Key manager - AD
    - Access Keyvault through CLI - 
    ```bash
    az keyvault create --name --resource-group --location
    ```
    - Access the keyvault through Portal.
    - 

### Lab 4

```c#
using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Storage;
using Microsoft.Azure.Storage.Blob;



public static async Task<IActionResult> Run(HttpRequest req)
{
    // Skaffer access til fil
    string connectionString = Environment.GetEnvironmentVariable("StorageConnectionString");
    CloudStorageAccount account = CloudStorageAccount.Parse(connectionString);
    CloudBlobClient blobClient = account.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference("drop");
    CloudBlockBlob blob = container.GetBlockBlobReference("records.json");
    


    // nytt Policy-object 
    SharedAccessAccountPolicy policy = new SharedAccessAccountPolicy()
    {
        Permissions = SharedAccessAccountPermissions.Read,
        Services = SharedAccessAccountServices.Blob,
        ResourceTypes = SharedAccessAccountResourceTypes.Object,
        SharedAccessExpiryTime = DateTime.UtcNow.AddHours(2),
        Protocols = SharedAccessProtocol.HttpsOnly
        
    };

    string sasToken = account.GetSharedAccessSignature(policy);
    string secureBlobUrl = blob.Uri+sasToken;
    return new OkObjectResult(secureBlobUrl);
}
```


### Questions
- Senario: Many companies {....} multi-tenant 
- How do you implement OAuth 2 implementation. 
- What can RBACS do: reader, contributer, owner: Senario: setup storage account, make sure who and how to access
    - What role to provide for A and B
- Given this security on this group: what can they do. Remember inheritance in AD. SCOPES
- Learn Azure RBAC roles
- Concentrate on C# RBAC
- Would you benefit from TEE?
- How to Access keyvault?
- What example of the CLI will work?

## AZ203-05-A

### Notes
- Log or Metrics
- Log: 
    - Own query language
    - Application monitoring data
    - Guest os data
    - Resource monitorign
    - Azure subscription monitoring data
 - Monitor for Containers
    - Kubernetes
    - Metrics API
    - Remediation: Respond to critical situations
    - Alerts: Action groups: Information to certain people
    - Autoscale: Rules for autoscale -- spin up instances if needed. 
- Application insights-
    - dependencies
    - exceptions
    - page views
    - AJAX calls
    - User and session counts
    - performance counters - from Linux, windows on prem servers
- Scaling
    - Autoscale regular profile: Not on particular day.
        - Always one profile defined
        - Two rules, chooses the maximum capacity. 
        - What containers can be Autoscaled --> must be enabled for autoscale
    - Best practise
        - Only one Autoscale setting
        - Can have multiple profiles
    - AZ quering
        ```
         az vm list --query [].{name:name, image:storageProfile}
         az vm list --query "[? starts with]
         ```
    - Fulent SDK quering
        ```C#
        Azure = azure = Azure.authenticate
        ```
    - LINQ queries
- Error handling code
    - for loop handles tansient exceptions
- Azure Cache for Redis
    - Fast storage in Memory.
    - Strings, hashed
    - Associed with keys
        - Use keys that describes data
    - Stored in nodes
- Content delivery network
    - Brings static files closer to
        - Lower latency
        - Static content
        - Images
        - Videos
    - Manged through CLI
        ```bash
        az cdn profiles list
        --sku unique identfier
        ```
    - 
### Questions
- What will this log-query return?
- What autoscaling rule will take presidence 
- Query resources using CLI:
- What the difference between single (basic), multiple(standard), persist with snapshop (Premium)
-  