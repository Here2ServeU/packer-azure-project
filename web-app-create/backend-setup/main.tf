provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "backend_rg" {
  name     = var.backend_resource_group
  location = var.azure_region
}

resource "azurerm_storage_account" "backend_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "backend_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.backend_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_account_network_rules" "backend_rules" {
  storage_account_id = azurerm_storage_account.backend_storage.id
  default_action     = "Allow"
}
