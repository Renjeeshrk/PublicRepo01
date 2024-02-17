terraform {
  backend "azurerm" {
    resource_group_name  = "azlabrg01"
    storage_account_name = ""
    container_name       = ""
    key                  = "terraform.tfstate"
  }
}  
