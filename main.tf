
      terraform {
         required_version = ">= 1.0.3"
      }
#################
# GRUPO DE RECURSOS
#################
resource "azurerm_resource_group" "Rg" {
  name     = "${var.prefix}-rg"
  location = "${var.az_location}"
}