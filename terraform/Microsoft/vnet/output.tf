output "virtual_network" {
  value       = azurerm_virtual_network.main
  description = "Created VNET"
}

output "backend_subnet" {
  value       = azurerm_subnet.backend
  description = "Created subnet backend"
}

output "frontend_subnet" {
  value       = azurerm_subnet.frontend
  description = "Created VNET"
}

output "virtual_network_id" {
  value       = azurerm_virtual_network.main.id
  description = "Created VNET ID"
}

output "backend_subnet_id" {
  value       = azurerm_subnet.backend.id
  description = "Created subnet backend id"
}

output "frontend_subnet_id" {
  value       = azurerm_subnet.frontend.id
  description = "Created subnet frontend id"
}