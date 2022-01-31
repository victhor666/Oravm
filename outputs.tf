output "vnet_name" {
  description = "Nombre de la Vnet creada para el Oracle"
  value       = azurerm_virtual_network.OracelVnet.name
}
output "vnet_id" {
      description = "ID de la Vnet. "
      value       = azurerm_virtual_network.OracelVnet.id
    }
output "vnet_CIDR" {
      description = "CIDR de la vnet "
      value       = azurerm_virtual_network.OracelVnet.address_space
    }    
    
output "Subnet_Name" {
      description = "Nombre de la subred creada "
      value       =  azurerm_subnet.OracelSubnet1.name
    }
output "Subnet_id" {
      description = "ID de la subred. "
      value       = azurerm_subnet.OracelSubnet1.id
    }
output "Subnet_CIDR" {
      description = "CIDR de la subnet "
      value       = azurerm_subnet.OracelSubnet1.address_prefixes
    }


output "vnet_dedicated_security_group_Name" {
       description = "Nombre del grupo de seguridad aplicado a la subred "
       value       = azurerm_network_security_group.oracle_nsg.name
   }
output "vnet_dedicated_security_group_id" {
       description = "ID del grupo de seguridad "
       value       = azurerm_network_security_group.oracle_nsg.id
   }
output "vnet_dedicated_security_ingress_rules" {
      description = "Reglas de entrada del grupo de seguridad "
     value       = azurerm_network_security_group.oracle_nsg.security_rule
}      
    # formatlist("%s:  %s" ,azurerm_network_security_group.terra_sg.ingress[*].description,formatlist("%s , CIDR: %s", azurerm_network_security_group.terra_sg.ingress[*].to_port,azurerm_network_security_group.terra_sg.ingress[*].cidr_blocks[0]))


  



