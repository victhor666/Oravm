
      terraform {
         required_version = ">= 1.0.3"
      }

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = "${var.az_location}"
}