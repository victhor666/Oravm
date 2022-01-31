resource "azurerm_network_interface" "OraNic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "Configuracion_ip"
    subnet_id                     = azurerm_subnet.terra_sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.terrapubip.id
  }
}
  resource "azurerm_public_ip" "IpPublica" {
  name                = "TerraPublicIp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"

  tags = {
    app = "IP-estatica "
  }
}

resource "azurerm_network_interface_security_group_association" "AsocSG" {
  network_interface_id      = azurerm_network_interface.OraNic.id
  network_security_group_id = azurerm_network_security_group.Oracle_Nsg.id
}
resource "azurerm_linux_virtual_machine" "OraVm" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.OraNic.id]
  size               = var.vm_size
  computer_name  = "OracleVM"
  admin_username = var.os_publisher[var.OS].admin
  disable_password_authentication = true
  provision_vm_agent = true
  custom_data    = base64encode ("${file(var.user_data)}")
        #custom_data    = "${path.root}/scripts/middleware_disk.sh"

admin_ssh_key {
    username = var.os_publisher[var.OS].admin
    public_key = file("~/orauser.pub")
  }
######################
# IMAGEN
######################  
 source_image_reference {
    publisher = var.os_publisher[var.OS].publisher
    offer     = var.os_publisher[var.OS].offer
    sku       = var.os_publisher[var.OS].sku
    version   = "latest"
  }
 
 


  # Si comentamos esta línea la máquina se apagara pero no se borrará automaticamente
  delete_os_disk_on_termination = true
  # Y lo mismo con los discos
  delete_data_disks_on_termination = true
  
  

######################
# VOLUMEN
######################  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.osdisk_size
  }
 
  tags = {
    environment = "Orademo"
  }
}
