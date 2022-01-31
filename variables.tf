# Azure account region and authentication 
variable "prefix" {
  default="Ora"
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

# VARIABLES SIMPLIFICADAS PARA LA INSTANCIA

      variable "Nombre_Instancia" {
        default = "OraVM"
      }


      variable "osdisk_size" {
        default = "30"
      }
      variable "vm_size" {
        default = "Standard_B1s"
      }

variable  "os_publisher" {
  default = {
    OL7    =  {
          publisher = "Oracle"
          offer     = "racle-Linux"
          sku       = "ol77-ci-gen2"
        },
    CENTOS7 = {
           publisher = "OpenLogic"
           offer     = "CentOS"
           sku       = "7.7"
           admin     = "centos"
        },
    RHEL7  =  {
          publisher = "RedHat"
          offer     = "RHEL"
          sku       = "7lvm-gen2"
          admin     = "azureuser"
        },

    WINDOWS    =  {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2016-Datacenter"
          admin     = "azureuser"
        },
    SUSE       =  {
          publisher = "SUSE"
          offer     = "sles-15-sp2-byos"
          sku       = "gen2"
          admin     = "azureuser"
        },
    UBUNTU       =  {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "19_10-daily-gen2"
          admin     = "azureuser"
        }
    


       }
     }  
variable "OS" {
  description = "El sistema operativo elegido es"
  default       = "Oracle" 
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