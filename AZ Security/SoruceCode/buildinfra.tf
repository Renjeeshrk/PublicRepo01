# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
# Crate Resource Group

resource "azurerm_resource_group" "infra-rg01" {
    name = "Production-RG-infra"
    location = "eastus"
  
}
# Create Virtual network and subnet 
resource "azurerm_virtual_network" "infra-network" {
  name                = "Production-vNet-infra"
  location            = azurerm_resource_group.infra-rg01.location
  resource_group_name = azurerm_resource_group.infra-rg01.name
  address_space       = ["192.168.0.0/16"]


  subnet {
    name           = "Production-Hub-infra"
    address_prefix = "192.168.20.0/23"
  }


}
