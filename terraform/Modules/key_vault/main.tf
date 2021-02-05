# Used to assign current user to the key vault access policy
data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault" "kv" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true

  sku_name = var.sku_name

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags
}


resource "azurerm_key_vault_access_policy" "sp_terraform" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  certificate_permissions = [
    "create",
    "delete",
    "deleteissuers",
    "get",
    "getissuers",
    "import",
    "list",
    "listissuers",
    "managecontacts",
    "manageissuers",
    "setissuers",
    "update",
  ]

  key_permissions = [
    "backup",
    "create",
    "decrypt",
    "delete",
    "encrypt",
    "get",
    "import",
    "list",
    "purge",
    "recover",
    "restore",
    "sign",
    "unwrapKey",
    "update",
    "verify",
    "wrapKey",
  ]

  secret_permissions = [
    "backup",
    "delete",
    "get",
    "list",
    "purge",
    "recover",
    "restore",
    "set",
  ]
}

resource "null_resource" "wait_policy" {
  depends_on = [azurerm_key_vault_access_policy.sp_terraform]

  provisioner "local-exec" {
    command     = "sleep 60"
    interpreter = ["bash", "-c"]
  }
}


resource "azurerm_monitor_diagnostic_setting" "kv_diag_settings" {
  name                       = var.name
  target_resource_id         = azurerm_key_vault.kv.id
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
