# Azure Storage
The Azure Storage platform is Microsoft's cloud storage solution for modern data storage scenarios. Azure Storage offers highly available, massively scalable, durable, and secure storage for 
a variety of data objects in the cloud.
## Storage Account 
An Azure storage account contains all of your Azure Storage data objects: blobs, files, queues, and tables. The storage account provides a unique namespace for your Azure Storage data that's
accessible from anywhere in the world over HTTP or HTTPS.

![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/bfbfad41-8bd9-4c94-bbd3-1854665dee6c)

## Components of Storage Account 
* Account Type - Determines features and costs
  * General Purpose V1 - Legacy for blobs , files , queues and tables 
  * General Purpose V2 - Recommended for Blobs , files ,queues and tables 
* Performance Tier - Determines performance level
  * Standard - Default Storage performance tier ,Recommended for most scenarios using Azure Storage.
  * Permium - Premium storage account type for block blobs and append blobs. Recommended for scenarios with high transaction rates or that use smaller objects or require consistently low storage latency
     * Premium block blobs -Premium storage account type for block blobs and append blobs. Recommended for scenarios with high transaction rates or that use smaller objects or require consistently low storage latency
     * Premium file shares - Premium storage account type for file shares only. Recommended for enterprise or high-performance scale applications. Use this account type if you want a storage account that supports both Server Message Block (SMB) and NFS file shares.
     * Premium page blob -Premium storage account type for page blobs only.
* Replication - Determines infrastrucutre redundancy
  * Locally redundant storage (LRS) copies your data synchronously three times within a single physical location in the primary region. LRS is the least expensive replication option, but isn't recommended for applications requiring high availability or durability.
  * Zone-redundant storage (ZRS) copies your data synchronously across three Azure availability zones in the primary region. For applications requiring high availability, Microsoft recommends using ZRS in the primary region, and also replicating to a secondary region.
  * Geo-redundant storage (GRS) copies your data synchronously three times within a single physical location in the primary region using LRS. It then copies your data asynchronously to a single physical location in a secondary region that is hundreds of miles away from the primary region. GRS offers durability for storage resources of at least 99.99999999999999% (16 9's) over a given year.
  * Geo-zone-redundant storage - Geo-zone-redundant storage (GZRS) combines the high availability provided by redundancy across availability zones with protection from regional outages provided by geo-replication. Data in a GZRS storage account is copied across three Azure availability zones in the primary region and is also replicated to a secondary geographic region for protection from regional disasters. Microsoft recommends using GZRS for applications requiring maximum consistency, durability, and availability, excellent performance, and resilience for disaster recovery.
    [MS Documentation](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy) 
* Access Tier  - Determines access levels and data costs
  * Host - An online tier optimized for storing data that is accessed or modified frequently. The hot tier has the highest storage costs, but the lowest access costs.
  * Cold - An online tier optimized for storing data that is rarely accessed or modified, but still requires fast retrieval. Data in the cold tier should be stored for a minimum of 90 days. The cold tier has lower storage costs and higher access costs compared to the cool tier.
  * Archive -  An offline tier optimized for storing data that is rarely accessed, and that has flexible latency requirements, on the order of hours. Data in the archive tier should be stored for a minimum of 180 days.
    
    [MS Documentation](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy](https://learn.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview)https://learn.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview) 

