
resource "azurerm_eventhub_namespace" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  capacity            = var.capacity

  # auto_inflate_enabled = var.auto_inflate_enabled

  tags = var.tags
}

resource "azurerm_eventhub" "main" {
  name                = var.name
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention
}


resource "azurerm_monitor_diagnostic_setting" "eventhub_namespace_diag_settings" {
  name                       = var.name
  target_resource_id         = azurerm_eventhub_namespace.main.id
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
