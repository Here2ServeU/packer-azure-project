variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "azure_region" {
  description = "Azure region for deployment"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "source_image_id" {
  description = "Custom image ID created by Packer"
  type        = string
}
