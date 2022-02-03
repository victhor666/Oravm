resource "azurerm_network_interface" "OraNic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.Rg.location
  resource_group_name = azurerm_resource_group.Rg.name

  ip_configuration {
    name                          = "Configuracion_ip"
    subnet_id                     = azurerm_subnet.Oracle_Subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.IpPublica.id
  }
}
resource "azurerm_public_ip" "IpPublica" {
  name                = "IP-Publica"
  resource_group_name = azurerm_resource_group.Rg.name
  location            = azurerm_resource_group.Rg.location
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
  name                            = "${var.prefix}-vm"
  location                        = azurerm_resource_group.Rg.location
  resource_group_name             = azurerm_resource_group.Rg.name
  network_interface_ids           = [azurerm_network_interface.OraNic.id]
  size                            = var.vm_size
  computer_name                   = "OracleVM"
  admin_username                  = "azureuser"
  disable_password_authentication = true
  provision_vm_agent              = true
  custom_data                     = base64encode("${file(var.user_data)}")


  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/Oravm/orauser.pub")
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
 ######################
  # VOLUMEN
  ######################
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.osdisk_size
  }
########################
##Provisioners Aqui podremos poner que copie ficheros de local al servidor o que se ejecuten tareas en remoto con remote-exec
########################
#  provisioner "file" {
#     source = "./main.tf"
#     destination = "/tmp/hola.txt"
#     connection {
#       type = "ssh"
#       user = "azureuser"
#       host = azurerm_linux_virtual_machine.OraVm.public_ip_address
#       private_key = file("~/orauser")
#       timeout  = "2m"
#     }
#   }
#  provisioner "file" {
#     source = "./main.tf"
#     destination = "/tmp/hola.txt"
#     connection {
#       type = "ssh"
#       user = "azureuser"
#       host = azurerm_linux_virtual_machine.OraVm.public_ip_address
#       private_key = file("~/orauser")
#       timeout  = "2m"
#     }
#   }


  tags = {
    environment = "Orademo"
  }
}
###############################
## Agregamos un disco adicional
###############################
resource "azurerm_managed_disk" "disco2" {
  name                            = "${var.prefix}-vm-disco2"
  location                        = azurerm_resource_group.Rg.location
  resource_group_name             = azurerm_resource_group.Rg.name
  storage_account_type            = "Standard_LRS"
  create_option                   = "Empty"
  disk_size_gb                    = var.disco2_size
}
resource "azurerm_managed_disk" "disco3" {
  name                            = "${var.prefix}-vm-disco3"
  location                        = azurerm_resource_group.Rg.location
  resource_group_name             = azurerm_resource_group.Rg.name
  storage_account_type            = "Standard_LRS"
  create_option                   = "Empty"
  disk_size_gb                    = var.disco3_size
}

resource "null_resource" "previous" {}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "60s"
}

resource "azurerm_virtual_machine_data_disk_attachment" "disco2" {
  managed_disk_id    = azurerm_managed_disk.disco2.id
  virtual_machine_id = azurerm_linux_virtual_machine.OraVm.id
  lun                = "1"
  caching            = "ReadWrite"
}
resource "null_resource" "previous2" {}

resource "time_sleep" "wait_20_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "20s"
}
resource "azurerm_virtual_machine_data_disk_attachment" "disco3" {
  managed_disk_id    = azurerm_managed_disk.disco3.id
  virtual_machine_id = azurerm_linux_virtual_machine.OraVm.id
  lun                = "2"
  caching            = "ReadWrite"
}