# Getting Started with Terraform for Azure 
## The Basics 
Terraform is an infrastructure as code tool which can be used to manage the resources in both cloud and on-prem resoucess .You can then use a workflows to provision and manage all of your infrastructure throughout its lifecycle.

Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs)
![image](https://github.com/Renjeeshrk/RK_Public/assets/51906504/2bfd1e6d-2be8-4048-94ec-42610919c5b1)

## Three stages in Terraform 
* Write
  *  Define the infrastructure as code
* Plan
  *  Review the changes that is going to implement 
* Apply
  *  Apply the code to build/change the infrastrcuture
## Get your tool kit ready 
* Terraform
* Git
* Azure CLI
* Visual Studio Code
  
### Setting up your infrastructure-as-code workstation 
Its important to have your infrastracture-as-code platform in a consistent environmnet
Here we are using Chocoloately to automate the installation 

1. Navigate to https://chocolatey.org/install
2. Copy the installation script and run it on your local machine
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
3. This will install the chocolatey package on your machine
4. Now lets create the required packages from chocolatey
5. Navigate to https://community.chocolatey.org/packages
6. Search for Terraform and click add button
  ![image](https://github.com/Renjeeshrk/RK_Public/assets/51906504/537efa6a-04d4-4ea3-b477-8dfb7ff1525a)
8. Repeate the same for other tools
9. Once all the tools are added click on generate script
    
  ![image](https://github.com/Renjeeshrk/RK_Public/assets/51906504/7bf9c0a6-c8d3-4e59-a7a1-2df44fbaa3dd)
 
11. Follow the package creation page, Select Indivudual for the integration method 
12. Copy the the script
    
  ![image](https://github.com/Renjeeshrk/RK_Public/assets/51906504/3957a278-6811-4b1f-a801-5fde32dfe2d0)

14. Run the script on your machine to install all the packages 

