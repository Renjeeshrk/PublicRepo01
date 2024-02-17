# Getting Started with Terraform for Azure 
## The Basics 
Terraform is an infrastructure as code tool which can be used to manage the resources in both cloud and on-prem resoucess .You can then use a workflows to provision and manage all of your infrastructure throughout its lifecycle.
Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs)
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/a618d3a6-7df8-4c5d-805e-336ae80c9b4d)


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
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/e9f37958-fa8d-477b-a21d-4e2fb8c5c331)

8. Repeate the same for other tools
9. Once all the tools are added click on generate script
    
![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/248abbbf-716c-4864-8571-9147fef83384)

11. Follow the package creation page, Select Indivudual for the integration method 
12. Copy the the script
    
 ![image](https://github.com/Renjeeshrk/PublicRepo01/assets/51906504/b8d17a60-00ec-4a96-b5ca-cdeb3e626223)
14. Run the script on your machine to install all the packages 

