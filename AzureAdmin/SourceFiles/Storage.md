# Azure Storage
The Azure Storage platform is Microsoft's cloud storage solution for modern data storage scenarios. Azure Storage offers highly available, massively scalable, durable, and secure storage for 
a variety of data objects in the cloud.
Azure Storage can support three categories of data: structured data, unstructured data, and virtual machine data.
## Considerations when using Azure Storage
* Consider durability and availability. Azure Storage is durable and highly available. Redundancy ensures your data is safe during transient hardware failures. You replicate data across datacenters or geographical regions for protection from local catastrophe or natural disaster. Replicated data remains highly available during an unexpected outage
* Consider secure access. Azure Storage encrypts all data. Azure Storage provides you with fine-grained control over who has access to your data.
* Consider scalability. Azure Storage is designed to be massively scalable to meet the data storage and performance needs of modern applications.
* Consider manageability. Microsoft Azure handles hardware maintenance, updates, and critical issues for you.
* Consider data accessibility. Data in Azure Storage is accessible from anywhere in the world over HTTP or HTTPS. Microsoft provides SDKs for Azure Storage in various languages

## Azure Storage services
* Azure Blob Storage (containers): A massively scalable object store for text and binary data.
   * Serving images or documents directly to a browser.
   * Storing files for distributed access.
   * Streaming video and audio.
   * Storing data for backup and restore, disaster recovery, and archiving.
   * Storing data for analysis by an on-premises or Azure-hosted service.
   * We can access data from Azure Blob Storage by using the NFS protocol.
* Azure Files: Managed file shares for cloud or on-premises deployments.
  * Azure Files enables you to set up highly available network file shares. Shares can be accessed by using the Server Message Block (SMB) protocol and the Network File System (NFS) protocol. Multiple virtual machines can share the same files with both read and write access. You can also read the files by using the REST interface or the storage client libraries.
  * Configuration files can be stored on a file share and accessed from multiple virtual machines
  * Diagnostic logs, metrics, and crash dumps are just three examples of data that can be written to a file share and processed or analyzed later.
* Azure Queue Storage: A messaging store for reliable messaging between application components.
   * Azure Queue Storage is used to store and retrieve messages.
   * Queue messages can be up to 64 KB in size, and a queue can contain millions of messages
   * Queues are used to store lists of messages to be processed asynchronously.
* Azure Table Storage: A service that stores nonrelational structured data (also known as structured NoSQL data).
   * Azure Table storage is a service that stores non-relational structured data (also known as structured NoSQL data) in the cloud
     
  
## Storage Account 
An Azure storage account contains all of your Azure Storage data objects: blobs, files, queues, and tables. The storage account provides a unique namespace for your Azure Storage data that's
accessible from anywhere in the world over HTTP or HTTPS.


<img src="https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/bfbfad41-8bd9-4c94-bbd3-1854665dee6c"  width="400" height="200">

## Components of Storage Account 
* Account Type - Determines features and costs
  * General Purpose V1 - Legacy for blobs , files , queues and tables 
  * General Purpose V2 - Recommended for Blobs , files ,queues and tables 
* Performance Tier - Determines performance level
  * Standard - Default Storage performance tier ,Recommended for most scenarios using Azure Storage.Standard storage  accounts are backed by magnetic hard disk drives (HDD)
  * Permium - Premium storage account type for block blobs and append blobs. Recommended for scenarios with high transaction rates or that use smaller objects or require consistently low storage latency.Premium storage accounts are backed by solid-state drives (SSD) and offer consistent low-latency performance
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
  * Hot - An online tier optimized for storing data that is accessed or modified frequently. The hot tier has the highest storage costs, but the lowest access costs.
  * Cold - An online tier optimized for storing data that is rarely accessed or modified, but still requires fast retrieval. Data in the cold tier should be stored for a minimum of 90 days. The cold tier has lower storage costs and higher access costs compared to the cool tier.
  * Archive -  An offline tier optimized for storing data that is rarely accessed, and that has flexible latency requirements, on the order of hours. Data in the archive tier should be stored for a minimum of 180 days.
    
    [MS Documentation](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy](https://learn.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview)https://learn.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview) 
## Access storage
Every object you store in Azure Storage has a unique URL address. 
<img src="https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/3c169693-edf9-4f54-990b-83ce2a982e39"  width="400" height="200">

### Configure custom domains
We can configure a custom domain to access blob data in your Azure storage account.Azure Storage doesn't currently provide native support for HTTPS with custom domains. You can implement an Azure Content Delivery Network (CDN) to access blobs by using custom domains over HTTPS.
There are two ways to configure a custom domain: direct mapping and intermediary domain mapping.
* Direct mapping lets you enable a custom domain for a subdomain to an Azure storage account. For this approach, you create a CNAME record that points from the subdomain to the Azure storage account
* Intermediary domain mapping is applied to a domain that's already in use within Azure. This approach might result in minor downtime while the domain is being mapped. To avoid downtime, you can use the asverify intermediary domain to validate the domain. By prepending the asverify keyword to your own subdomain, you permit Azure to recognize your custom domain without modifying the DNS record for the domain. After you modify the DNS record for the domain, your domain is mapped to the blob endpoint with no downtime.

## Secure storage endpoints
* The Firewalls and virtual networks settings restrict access to your storage account from specific subnets on virtual networks or public IPs.
* You can configure the service to allow access to one or more public IP ranges.
* Subnets and virtual networks must exist in the same Azure region or region pair as your storage account.






