provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "t2s_rg" {
  name     = "t2s-deployment-group"
  location = "East US"
}

resource "azurerm_virtual_network" "t2s_vnet" {
  name                = "t2s-vnet"
  location            = azurerm_resource_group.t2s_rg.location
  resource_group_name = azurerm_resource_group.t2s_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "t2s_subnet" {
  name                 = "t2s-subnet"
  resource_group_name  = azurerm_resource_group.t2s_rg.name
  virtual_network_name = azurerm_virtual_network.t2s_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "t2s_nic" {
  name                = "t2s-nic"
  location            = azurerm_resource_group.t2s_rg.location
  resource_group_name = azurerm_resource_group.t2s_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.t2s_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "t2s_vm" {
  name                = "t2s-vm"
  resource_group_name = azurerm_resource_group.t2s_rg.name
  location            = azurerm_resource_group.t2s_rg.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.t2s_nic.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/<subscription_id>/resourceGroups/t2s-image-group/providers/Microsoft.Compute/images/t2s-custom-image"
}
