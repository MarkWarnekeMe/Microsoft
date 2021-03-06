output "application_insights" {
  value = azurerm_application_insights.main
}

output "id" {
  value = azurerm_application_insights.main.id
}

output "instrumentation_key" {
  value = azurerm_application_insights.main.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.main.app_id
}