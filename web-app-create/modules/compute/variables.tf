variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the Subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = string
}

variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "nic_name" {
  description = "The name of the Network Interface"
  type        = string
}

variable "public_ip_name" {
  description = "The name of the Public IP"
  type        = string
}

variable "vm_name" {
  description = "The name of the Virtual Machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the Virtual Machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the Virtual Machine"
  type        = string
}

variable "ssh_public_key" {
  description = "Path to the SSH public key"
  type        = string
}

variable "image_publisher" {
  description = "The image publisher for the VM"
  type        = string
}

variable "image_offer" {
  description = "The image offer for the VM"
  type        = string
}

variable "image_sku" {
  description = "The image SKU for the VM"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g., dev, stage, prod)"
  type        = string
}
