# Azure account region and authentication 
variable "prefix" {
  default="ora"
  description = "Prefijo para todo"
}

variable "az_location" {
    default = "eastus"
}
# INFO VPC
    variable "vnet_name" {
      default = "OracleVnet"
    }
    
    variable "vnet_cidr" {
      default = "192.168.0.0/16"
    }

# INFO SUBNET
    variable "subnet_name"{
      default = "OracleSubet1" 
      }

    variable "subnet_cidr"{
      default = "192.168.10.0/24"
      } 
  variable "sg_name" {
    default = "oracle_sg"
  }
