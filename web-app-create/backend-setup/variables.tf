variable "backend_resource_group" {
  description = "Name of the Azure resource group for backend storage"
  type        = string
}

variable "azure_region" {
  description = "Azure region for the backend storage"
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name for Terraform backend"
  type        = string
}

variable "container_name" {
  description = "Storage container name for Terraform state files"
  type        = string
}
