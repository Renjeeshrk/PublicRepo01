# Build infrastructure
In this session, we will will create a Terraform configuration to deploy an Azure resource group and network. 

## What you need ? 
* An Azure Subscription
* Terraform Latest version
* Azure CLI Installed
* Vistual Studio Code

Terraform configuration designed with the HashiCorp Configuration Language (HCL), a declarative language crafted exclusively for Terraform. HCL boasts a human-readable syntax, facilitating user comprehension of infrastructure resource configurations. Moreover, HCL offers robust resource orchestration features, including input variables, outputs, data sources, and modules. These elements enable the creation of reusable and composable infrastructure definitions.

![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/4bf20c0a-8ec6-44e9-aabe-ebb786761ab2)

## ProvidersEach provider adds a set of resource types and/or data sources that Terraform can manage.

Every resource type is implemented by a provider; without providers, Terraform can't manage any kind of infrastructure.Terraform depends on providers, which are plugins enabling interaction with cloud providers, SaaS platforms, and various APIs.
The Terraform Registry is the main directory of publicly available Terraform providers, and hosts providers for most major infrastructure platforms.
https://registry.terraform.io/browse/providers

### Time to code the First program to Create a Resource Group and a vNet in Azure 
The first two blocks of the code defined the provider source and the version being used for , the the remaining configuration can be added. The full code is avaialble here - 
https://github.com/Renjeeshrk/PublicRepo01/blob/f8d128fd9e25bd0c7b587a27e2db5816d33cacc8/Terraform/buildinfra.tf

### How to run the Code 
1. **Initialize the Configuration**
Run terraform init in the directory containing your Terraform configuration files. This command initializes your working directory, downloads the necessary providers, and sets up the backend. 
2. **Review Execution Plan**
Before making any changes, it's a good practice to review the execution plan. Run terraform plan to see a summary of what Terraform will do without actually making any changes.
3. **Apply Changes**
If the execution plan looks correct, apply the changes using terraform apply. This command will create, modify, or destroy resources based on your Terraform configuration.
