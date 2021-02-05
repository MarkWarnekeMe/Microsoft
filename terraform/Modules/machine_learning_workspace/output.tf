output "machine_learning_workspace" {
  value       = azurerm_machine_learning_workspace.main
  description = "The Machine Learning Workspace."
}

output "id" {
  value       = azurerm_machine_learning_workspace.main.id
  description = "The ID of the Machine Learning Workspace."
}

output "azurerm_storage_account" {
  value = azurerm_storage_account.main
}

output "key_vault" {
  value = module.key_vault
}

output "application_insights" {
  value = module.application_insights
}