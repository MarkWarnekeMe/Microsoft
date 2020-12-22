resource "azurerm_application_insights" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = var.application_type

  retention_in_days    = var.retention_in_days
  daily_data_cap_in_gb = var.daily_data_cap_in_gb
  tags                 = var.tags
}