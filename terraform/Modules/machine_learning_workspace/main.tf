
data "azurerm_client_config" "current" {}

module "application_insights" {
  source = "../application_insights"

  name                = format("%s%s", var.name, var.randomId)
  location            = var.location
  resource_group_name = var.resource_group_name

  application_type = "web"

  tags = var.tags
}

module "key_vault" {
  source = "../key_vault"

  name                = substr(format("%s%s", var.name, var.randomId), 0, 23)
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name                   = var.key_vault_sku_name
  log_analytics_workspace_id = var.log_analytics_workspace_id

  tags = var.tags
}

resource "azurerm_storage_account" "main" {

  name                = substr(format("%s%s", var.name, var.randomId), 0, 23)
  location            = var.location
  resource_group_name = var.resource_group_name

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = var.tags
}

resource "azurerm_machine_learning_workspace" "main" {
  name = var.name

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