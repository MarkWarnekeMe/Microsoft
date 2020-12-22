output "azurerm_container_registry" {
  value       = azurerm_container_registry.main
  description = "The resource of the container registry"
}

output "id" {
  value       = azurerm_container_registry.main.id
  description = "The id of the container registry"
}

output "login_server" {
  value       = azurerm_container_registry.main.login_server
  description = "The URL that can be used to log into the container registry"
}
