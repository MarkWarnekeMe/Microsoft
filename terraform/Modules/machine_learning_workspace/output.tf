output "machine_learning_workspace" {
  value       = azurerm_machine_learning_workspace
  description = "The Machine Learning Workspace."
}

output "id" {
  value       = azurerm_machine_learning_workspace.id
  description = "The ID of the Machine Learning Workspace."
}