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
# Local variables
locals {
  hub_locationame = "eastus"
  spoke1_location = "eastus"
  spoke2_location = "westus"

  
}

# Crate Resource Group

resource "azurerm_resource_group" "az_project_secure" {
    name = "rg_az_project"
    location = local.hub_locationame
  
}
// Hub network Deployment  
resource "azurerm_virtual_network" "az_pr_hub_vnet" {
  name                = "az_pr-hub_vnet-01"
  location            = azurerm_resource_group.az_project_secure.location
  resource_group_name = azurerm_resource_group.az_project_secure.name
  address_space       = ["10.10.0.0/20"]
}
resource "azurerm_subnet" "fw_az_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  virtual_network_name = azurerm_virtual_network.az_pr_hub_vnet.name
  address_prefixes     = ["10.10.1.0/26"]
}
resource "azurerm_subnet" "gw_az_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  virtual_network_name = azurerm_virtual_network.az_pr_hub_vnet.name
  address_prefixes     = ["10.10.0.0/27"]
}
resource "azurerm_subnet" "bas_az_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  virtual_network_name = azurerm_virtual_network.az_pr_hub_vnet.name
  address_prefixes     = ["10.10.2.0/26"]
}

// Spoke 1 Creation 

resource "azurerm_virtual_network" "az_pr_spoke1_vnet" {
  name                = "az_pr_spoke1_vnet_01"
  location            = azurerm_resource_group.az_project_secure.location
  resource_group_name = azurerm_resource_group.az_project_secure.name
  address_space       = ["10.10.16.0/20"]
}
resource "azurerm_subnet" "az_pr_spoke1_FrontEnd_subnet" {
  name                 = "az_spoke1_frontEnd_subnet"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  virtual_network_name = azurerm_virtual_network.az_pr_spoke1_vnet.name
  address_prefixes     = ["10.10.16.0/23"]
}
resource "azurerm_subnet" "az_pr_spoke1_backEnd_subnet" {
  name                 = "az_spoke1_backend_subnet"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  virtual_network_name = azurerm_virtual_network.az_pr_spoke1_vnet.name
  address_prefixes     = ["10.10.18.0/23"]
}

// Spoke 2 Creation 

resource "azurerm_virtual_network" "az_pr_spoke2_vnet" {
  name                = "az_pr_spoke2_vnet_01"
  location            = local.spoke2_location
  resource_group_name = azurerm_resource_group.az_project_secure.name
  address_space       = ["10.10.32.0/20"]
}

resource "azurerm_subnet" "az_pr_spoke2_FrontEnd_subnet" {
  name                 = "az_spoke2_frontEnd_subnet"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  virtual_network_name = azurerm_virtual_network.az_pr_spoke2_vnet.name
  address_prefixes     = ["10.10.32.0/23"]
}
resource "azurerm_subnet" "az_pr_spoke2_backEnd_subnet" {
  name                 = "az_spoke2_backend_subnet"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  virtual_network_name = azurerm_virtual_network.az_pr_spoke2_vnet.name
  address_prefixes     = ["10.10.34.0/23"]
}


