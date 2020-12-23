output "virtual_network" {
  value       = azurerm_virtual_network.main
  description = "Created VNET"
}

output "backend_subnet" {
  value       = azurerm_subnet.backend
  description = "Created subnet backend"
}

output "backend_virtual_node_subnet" {
  value       = azurerm_subnet.backend_virtual_node
  description = "Created subnet backend for virtual node"
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

output "backend_virtual_node_subnet_id" {
  value       = azurerm_subnet.backend_virtual_node.id
  description = "Created subnet backend for virtual node id"
}

output "frontend_subnet_id" {
  value       = azurerm_subnet.frontend.id
  description = "Created subnet frontend id"
}