output "nsg_id" {
  description = "ID of the created Network Security Group"
  value       = azurerm_network_security_group.web_nsg.id
}

output "nsg_name" {
  description = "Name of the created Network Security Group"
  value       = azurerm_network_security_group.web_nsg.name
}
