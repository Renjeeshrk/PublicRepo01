# Basic Terminologies 
## Azure Azure Resouce manager (ARM)
Azure Resouce manager (ARM) is the orchestration layer for managing the Azure Cloud resources .It provides a management layer that enables you to create, update, and delete resources in your Azure account.
When you send a request through any of the Azure APIs, tools, or SDKs, Resource Manager receives the request. It authenticates and authorizes the request before forwarding it to the appropriate Azure service.

<img src="https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/8a2296d4-6b94-4b5f-97ff-3ae7eb6f54d1" width="400" height="200">

**Resource**
A manageable item that is available through Azure. Virtual machines, storage accounts, web apps, databases, and virtual networks are examples of resources. Resource groups, subscriptions, management groups, and tags are also examples of resources.

**Resource group**
A container that holds related resources for an Azure solution. The resource group includes those resources that you want to manage as a group

**Resource provider**
A service that supplies Azure resources. For example, a common resource provider is Microsoft.Compute, which supplies the virtual machine resource. Microsoft.Storage is another common resource provider

# Management levels and hierarchy
Azure provides four levels of management: management groups, subscriptions, resource groups, and resources.
<img src="https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/3ab31420-0a00-48e5-b527-cfb6a395077d" width="400" height="200">

**Management groups** help you manage access, policy, and compliance for multiple subscriptions. All subscriptions in a management group automatically inherit the conditions that are applied to the management group.

**Subscriptions** logically associate user accounts with the resources that they create. Each subscription has limits or quotas on the amount of resources that it can create and use. Organizations can use subscriptions to manage costs and the resources that are created by users, teams, and projects.

**Resource groups** are logical containers where you can deploy and manage Azure resources like web apps, databases, and storage accounts.

**Resources** are instances of services that you can create, such as virtual machines, storage, and SQL databases.

## Management settings scope
We can apply management settings, such as policies and role-based access control, at any management level. The level determines how widely the setting is applied. Lower levels inherit settings from higher levels. The best practice will be applying the common and critical policies at the managment level and project specific policies at resource group or resource level . 

