resource "azurerm_container_registry" "main" {
  name                     = var.name
  resource_group_name      = var.resource_group
  location                 = var.location
  sku                      = var.sku
  georeplication_locations = var.geo_rep_locations
  admin_enabled            = var.admin_enabled

  tags = local.tags
}


resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name                       = var.name
  target_resource_id         = azurerm_container_registry.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = [
      for category in var.log_categories : {
        name           = category.name
        enabled        = category.enabled
        retention_days = category.retention_days
      }
    ]
    content {
      category = log.value.name
      enabled  = log.value.enabled

      retention_policy {
        enabled = log.value.enabled
        days    = log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = [
      for category in var.metric_categories : {
        name           = category.name
        enabled        = category.enabled
        retention_days = category.retention_days
      }
    ]
    content {
      category = metric.value.name
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.enabled
        days    = metric.value.retention_days
      }
    }
  }
}