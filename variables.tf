# Azure account region and authentication
variable "prefix" {
  default     = "Ora"
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
variable "subnet_name" {
  default = "OracleSubet1"
}

variable "subnet_cidr" {
  default = "192.168.10.0/24"
}
variable "sg_name" {
  default = "oracle_sg"
}

# VARIABLES SIMPLIFICADAS PARA LA INSTANCIA

variable "Nombre_Instancia" {
  default = "OraVM"
}

variable "osdisk_size" {
  default = "30"
}
variable "disco2_size" {
  default = "7"
}
variable "disco3_size" {
  default = "10"
}
variable "vm_size" {
  default = "Standard_B2ms"
}

variable "os_publisher" {
  default = {
    OL7 = {
      publisher = "Oracle"
      offer     = "Oracle-Linux"
      sku       = "79-gen2"
    }
  }
}
variable "OS" {
  description = "El sistema operativo elegido es"
  default     = "OL7"
}

# VNIC INFO
variable "private_ip" {
  default = "192.168.10.51"
}

# BOOT INFO
# user data
variable "user_data" {
  default = "./userdata.txt"
}

# EBS
#
variable "network_interface" {
  description = "Personalizar interface en el arranque"
  type        = list(map(string))
  default     = []
}