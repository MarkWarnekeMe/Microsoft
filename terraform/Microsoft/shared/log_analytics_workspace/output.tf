output "azurerm_log_analytics_workspace" {
  description = "Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.main
}

output "azurerm_log_analytics_solution" {
  description = "Log Analytics Solutions"
  value       = azurerm_log_analytics_solution.sol
}

output "id" {
  value       = azurerm_log_analytics_workspace.main.id
  description = "The id of the log analytics workspace"
}
