 terraform {
      required_version = ">= 1.0.3"
    }
provider "azurerm" {
    features {
          }
    }
#################
# GRUPO DE RECURSOS
#################

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-Recursos"
  location = "${var.az_location}"
}

#################
# VNET
#################
resource "azurerm_virtual_network" "oracle_vnet" {
  name                = "${var.prefix}-network"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  address_space       = [var.vnet_cidr]
}
#################
# SUBREDES
#################
# aws_subnet.terra_sub:
resource "azurerm_subnet" "oracle_subnet" {
  name                 = "internal"
  virtual_network_name = "${azurerm_virtual_network.oracle_vnet.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefixes     = [var.subnet_cidr]
}

######################
# Network security groups
######################    

resource "azurerm_network_security_group" "oracle_nsg" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Egress"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "Salida a internet sin restricciones. Debe ser modificado mas adelante"
  }
security_rule {
    name                       = "Inbound HTTP access"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_ranges          = ["22","80","443"]
    destination_port_ranges     = ["22","80","443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "RDP-HTTP-HTTPS entradas estandar de gestion" 
  }

  
tags = {
    Name = "SSH ,HTTP, and HTTPS"
  }
    timeouts {}
}

resource "azurerm_subnet_network_security_group_association" "nsg_sub" {
  subnet_id                 = azurerm_subnet.oracle_subnet.id
  network_security_group_id = azurerm_network_security_group.oracle_nsg.id
}