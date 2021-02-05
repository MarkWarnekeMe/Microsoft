
data "azurerm_client_config" "current" {}


locals {
  name = substr(format("%s%s", var.name, var.randomId), 0, 23)
}

module "application_insights" {
  source = "../application_insights"

  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  application_type = "web"

  tags = var.tags
}

module "key_vault" {
  source = "../key_vault"

  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name                   = var.key_vault_sku_name
  log_analytics_workspace_id = var.log_analytics_workspace_id

  tags = var.tags
}

resource "azurerm_storage_account" "main" {

  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = var.tags
}

resource "azurerm_machine_learning_workspace" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name

  application_insights_id = module.application_insights.id
  key_vault_id            = module.key_vault.id
  storage_account_id      = azurerm_storage_account.main.id
  container_registry_id   = var.container_registry_id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  name                       = var.name
  target_resource_id         = azurerm_machine_learning_workspace.main.id
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
