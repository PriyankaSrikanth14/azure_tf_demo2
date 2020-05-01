resource "azurerm_linux_virtual_machine" "example" {
  count               = var.vm_count
  name                = "${var.prefix}-vm-${count.index}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = var.vm_size
  admin_username      = var.vm_username
  network_interface_ids = [element(azurerm_network_interface.example.*.id, "${count.index}")]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}


resource "azurerm_network_interface" "example" {
  count               = var.vm_count
  name                = "${var.prefix}-nic-${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id  = element(azurerm_public_ip.example.*.id, "${count.index}")
  }
}


resource "azurerm_public_ip" "example" {
  count               = var.vm_count
  name                = "${var.prefix}-pip-${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "development"
  }
}


output "vm_public_ip" {

    value = [azurerm_linux_virtual_machine.example.*.public_ip_address]
}








