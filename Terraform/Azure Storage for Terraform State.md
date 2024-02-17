# Using Azure Storage for Terraform State 
In this session will see how to configure Terraform to store the state files remotely in Azure Storage 
## What is Terraform State ? 
In simple words Terraform state is basically the current status of your infrastructure.It keeps track of resources declared in your configuration and maps them to resources in the actual environment.By the default, the state file is named terraform.state and is stored locally
## When you store the State Locally
* It doesn't work well in a team or collaborative Environment
* It can include sesitive data , which is not recommended to be in your local machine
* Increase chances for accidental deletion
## What you need to setup the remote storage 
* A Resource group in Azure
* A Storge account and container 
In this configuration we are going to configure a standard storage account with Locally redundant storage (LRS) replication

### Lets create the resouces required to store the State file 
The first step is to create the providers code ,we are adding this in a separete configuration file named -providers.tf
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/bd28f2e7-0bc5-4b83-957a-6d3d7c5c9ebd)


Lets create another configuration file to deploy the resources , File name - remote_state_storage.tf
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/cb118048-7e20-40e8-9715-f5ef27a1cf60)

Will use output option to print the storage account name and the container name 
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/b76d897d-76bc-4d94-b75f-5bd270ff863d)

After the initialization,lets validate the configuration 
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/ddff6c38-d41e-4bc4-aa7b-2dc5d9970bc1)
once the validation complete ; run terraform plan following apply to deploy the resources
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/040cc09b-b073-4aa6-8208-64f1d16d48b1)
The resources has been created successfully .

### Create the backend configuration to migrate the state file in to Azure Storage
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/305d5823-2a6f-4f44-b752-3abdfccb73f8)

You need to run the initialization command to make the changes 
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/e88d7818-24fe-4d90-a1c2-fcc0a17f0e1e)

### Review the state file in Azure Storage
Login to Azure portal and navigate to the storage account and makes sure state file is now migrated to the Azure storage
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/85462170-bc16-4981-abc1-574d90268205)

We can now remvoe the state file from local machine and run **terraform show** command to view the state file 

Use **terraform Destroy** to remove the resources created 

## When you save the state file in Azure storage 
* The data stored in azure blob is encrypted before being persisted
* Terraform will retrive the state from the Azure storage backend and store it in the local memory
* A state is never written to your local disk 
