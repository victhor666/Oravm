terraform {
  required_version = ">= 1.0.3"
}
provider "azurerm" {
  features {
  }
}

#################
# VNET
#################
resource "azurerm_virtual_network" "Oracle_Vnet" {
  name                = "${var.prefix}-network"
  resource_group_name = azurerm_resource_group.Rg.name
  location            = azurerm_resource_group.Rg.location
  address_space       = [var.vnet_cidr]
}
#################
# SUBREDES
#################
# aws_subnet.terra_sub:
resource "azurerm_subnet" "Oracle_Subnet" {
  name                 = "internal"
  virtual_network_name = azurerm_virtual_network.Oracle_Vnet.name
  resource_group_name  = azurerm_resource_group.Rg.name
  address_prefixes     = [var.subnet_cidr]
}

######################
# GRUPOS DE SEGURIDAD
######################

resource "azurerm_network_security_group" "Oracle_Nsg" {
  name                = "${var.prefix}-Nsg"
  location            = azurerm_resource_group.Rg.location
  resource_group_name = azurerm_resource_group.Rg.name

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
    source_port_ranges         = ["22", "80", "443"]
    destination_port_ranges    = ["22", "80", "443"]
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
  subnet_id                 = azurerm_subnet.Oracle_Subnet.id
  network_security_group_id = azurerm_network_security_group.Oracle_Nsg.id
}