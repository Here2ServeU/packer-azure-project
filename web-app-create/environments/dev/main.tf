terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-backend-rg"
    storage_account_name  = "tfstatestorage2025"
    container_name        = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  azure_region        = var.azure_region
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = var.resource_group_name
  azure_region        = var.azure_region
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_key             = file("~/.ssh/id_rsa.pub")
  source_image_id     = var.source_image_id
}
