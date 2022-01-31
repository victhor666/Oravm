# Azure account region and authentication 
variable "prefix" {
  default="ora"
  description = "The prefix used for all resources in this example"
}

variable "az_location" {
    default = "eastus"
}
# VPC INFO
    variable "vnet_name" {
      default = "OracleVnet"
    }
    
    variable "vnet_cidr" {
      default = "192.168.0.0/16"
    }

# SUBNET INFO
    variable "subnet_name"{
      default = "OracleSubet1" 
      }

    variable "subnet_cidr"{
      default = "192.168.10.0/24"
      } 
  variable "sg_name" {
    default = "oracle_sg"
  }
