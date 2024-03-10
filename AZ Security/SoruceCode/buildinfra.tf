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


# vNet Peering between Hub and Spoke 1
resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
  name                         = "hub-to-spoke1"
  resource_group_name          = azurerm_resource_group.az_project_secure.name
  virtual_network_name         = azurerm_virtual_network.az_pr_hub_vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.az_pr_spoke1_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "Spoke1_to_Hub" {
  name                         = "spoke1-to-hub"
  resource_group_name          = azurerm_resource_group.az_project_secure.name
  virtual_network_name         = azurerm_virtual_network.az_pr_spoke1_vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.az_pr_hub_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}


# vNet Peering between Hub and Spoke 2
resource "azurerm_virtual_network_peering" "hub_to_spoke2" {
  name                         = "hub-to-spoke2"
  resource_group_name          = azurerm_resource_group.az_project_secure.name
  virtual_network_name         = azurerm_virtual_network.az_pr_hub_vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.az_pr_spoke2_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "spoke2_to_hub" {
  name                         = "spoke2-to-hub"
  resource_group_name          = azurerm_resource_group.az_project_secure.name
  virtual_network_name         = azurerm_virtual_network.az_pr_spoke2_vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.az_pr_hub_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

# AzureNetwork DDoS Protection Plan

resource "azurerm_network_ddos_protection_plan" "az_pr_ddos_infra01" {
  name                = "az_ddos_pr_01"
  location            = local.hub_locationame
  resource_group_name = azurerm_resource_group.az_project_secure.name
}

resource "azurerm_network_ddos_protection_plan" "az_pr_ddos_infra02" {
  name                = "az_ddos_pr_02"
  location            = local.spoke2_location
  resource_group_name = azurerm_resource_group.az_project_secure.name
}

# Deploy Firewall to Hub network

resource "azurerm_ip_group" "Spoke1_ip" {
  name                = "workload-ip-group"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  location            = local.spoke1_location
  cidrs               = ["10.10.16.0/20"]
}
resource "azurerm_ip_group" "Spoke2_ip" {
  name                = "infra-ip-group"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  location            = local.spoke2_location
  cidrs               = ["10.10.32.0/20"]
}

resource "azurerm_public_ip" "pip_azfw" {
  name                = "pip-azfw"
  location            = local.spoke1_location
  resource_group_name = azurerm_resource_group.az_project_secure.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall_policy" "azfw_policy" {
  name                     = "azfw-policy"
  location            = local.spoke2_location
  resource_group_name = azurerm_resource_group.az_project_secure.name
  sku                      = var.firewall_sku_tier
  threat_intelligence_mode = "Alert"
}

resource "azurerm_firewall_policy_rule_collection_group" "net_policy_rule_collection_group" {
  name               = "DefaultNetworkRuleCollectionGroup"
  firewall_policy_id = azurerm_firewall_policy.azfw_policy.id
  priority           = 200
  network_rule_collection {
    name     = "DefaultNetworkRuleCollection"
    action   = "Allow"
    priority = 200
    rule {
      name                  = "time-windows"
      protocols             = ["UDP"]
      source_ip_groups      = [
        azurerm_ip_group.Spoke1_ip.id,
        azurerm_ip_group.Spoke2_ip.id,]
      destination_ports     = ["123"]
      destination_addresses = ["132.86.101.172"]
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "app_policy_rule_collection_group" {
  name               = "DefaulApplicationtRuleCollectionGroup"
  firewall_policy_id = azurerm_firewall_policy.azfw_policy.id
  priority           = 300
  application_rule_collection {
    name     = "DefaultApplicationRuleCollection"
    action   = "Allow"
    priority = 500
    rule {
      name = "AllowWindowsUpdate"

      description = "Allow Windows Update"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_ip_groups      = [
        azurerm_ip_group.Spoke1_ip.id,
        azurerm_ip_group.Spoke2_ip.id,]
      destination_fqdn_tags = ["WindowsUpdate"]
    }
    rule {
      name        = "Global Rule"
      description = "Allow access to Microsoft.com"
      protocols {
        type = "Https"
        port = 443
      }
      destination_fqdns = ["*.microsoft.com"]
      terminate_tls     = false
      source_ip_groups      = [
        azurerm_ip_group.Spoke1_ip.id,
        azurerm_ip_group.Spoke2_ip.id,]
    }
  }
}

resource "azurerm_firewall" "az_pr_fw" {
  name                = "az_pr_fw_01"
  location            = local.hub_locationame
  resource_group_name = azurerm_resource_group.az_project_secure.name
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku_tier
  ip_configuration {
    name                 = "azfw-ipconfig"
    subnet_id            = azurerm_subnet.fw_az_subnet.id
    public_ip_address_id = azurerm_public_ip.pip_azfw.id
  }
  firewall_policy_id = azurerm_firewall_policy.azfw_policy.id
}


# Route table Creation 

resource "azurerm_route_table" "az_pr_route" {
  name                = "z_pr_route_01"
  location            = local.hub_locationame
  resource_group_name = azurerm_resource_group.az_project_secure.name

  route {
    name                   = "Spoke1toFirwall"
    address_prefix         = "10.10.16.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.4"
  }

}

resource "azurerm_subnet_route_table_association" "route_assignment-spoke1" {
  subnet_id      = azurerm_subnet.az_pr_spoke1_FrontEnd_subnet.id 
  route_table_id = azurerm_route_table.az_pr_route.id
}

resource "azurerm_subnet_route_table_association" "route_assignment-spoke1_1" {
  subnet_id      = azurerm_subnet.az_pr_spoke1_backEnd_subnet.id
  route_table_id = azurerm_route_table.az_pr_route.id
}


resource "azurerm_route_table" "az_pr_route2" {
  name                = "az_pr_route_02"
  location            = local.spoke2_location
  resource_group_name = azurerm_resource_group.az_project_secure.name

  route {
    name                   = "Spoke2toFirwall"
    address_prefix         = "10.10.32.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.4"
  }
}

resource "azurerm_subnet_route_table_association" "route_assignment-spoke2" {
  subnet_id      = azurerm_subnet.az_pr_spoke2_FrontEnd_subnet.id 
  route_table_id = azurerm_route_table.az_pr_route2.id
}

resource "azurerm_subnet_route_table_association" "route_assignment-spoke2_1" {
  subnet_id      = azurerm_subnet.az_pr_spoke2_backEnd_subnet.id
  route_table_id = azurerm_route_table.az_pr_route2.id
}


# Create Webserver 01

resource "azurerm_network_interface" "web01-ip" {
  name                      = "web01-ip-LAN"
  location                  = azurerm_resource_group.az_project_secure.location
  resource_group_name       = azurerm_resource_group.az_project_secure.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az_pr_spoke1_FrontEnd_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.10.16.20"  # Specify the static IP address here
  }
}

resource "azurerm_linux_virtual_machine" "web01" {
  name                = "az-web-01"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  location            = local.spoke1_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.web01-ip.id
  ]

   admin_password = "******"  # Provide your desired admin password here

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

# Create Webserver 02

resource "azurerm_network_interface" "web02-ip" {
  name                      = "web02-ip-LAN"
  location                  = azurerm_resource_group.az_project_secure.location
  resource_group_name       = azurerm_resource_group.az_project_secure.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az_pr_spoke1_FrontEnd_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.10.16.21"  # Specify the static IP address here
  }
}

resource "azurerm_linux_virtual_machine" "web02" {
  name                = "az-web-02"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  location            = local.spoke1_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.web02-ip.id
  ]

 admin_password = "******"  # Provide your desired admin password here

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

## Create backend server


## Create network interface 
resource "azurerm_network_interface" "Data01-ip" {
  name                      = "Data01-ip-LAN"
  location                  = azurerm_resource_group.az_project_secure.location
  resource_group_name       = azurerm_resource_group.az_project_secure.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az_pr_spoke1_backEnd_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.10.18.20"  # Specify the static IP address here
  }
}

resource "azurerm_linux_virtual_machine" "Data01" {
  name                = "az-data-01"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  location            = local.spoke1_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.Data01-ip.id
  ]

  admin_password = "******"  # Provide your desired admin password here

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


## Backend Server 2
resource "azurerm_network_interface" "Data02-ip" {
  name                      = "Data02-ip-LAN"
  location                  = azurerm_resource_group.az_project_secure.location
  resource_group_name       = azurerm_resource_group.az_project_secure.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az_pr_spoke1_backEnd_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.10.18.21"  # Specify the static IP address here
  }
}

resource "azurerm_linux_virtual_machine" "Data02" {
  name                = "az-data-02"
  resource_group_name = azurerm_resource_group.az_project_secure.name
  location            = local.spoke1_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.Data02-ip.id
  ]

  admin_password = "******"  # Provide your desired admin password here

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
