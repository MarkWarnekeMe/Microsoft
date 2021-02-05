
data "azurerm_client_config" "current" {}


resource "azurerm_application_insights" "main" {
  name                = format("%s%s", var.name, var.randomId)
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"

  tags = var.tags
}

resource "azurerm_key_vault" "main" {
  name                = format("%s%s", var.name, var.randomId)
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku_name

  tags = var.tags
}

resource "azurerm_storage_account" "main" {
  name                     = format("%s%s", var.name, var.randomId)
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = var.tags
}

resource "azurerm_machine_learning_workspace" "main" {
  name = var.name

  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name

  application_insights_id = azurerm_application_insights.main.id

  key_vault_id       = azurerm_key_vault.main.id
  storage_account_id = azurerm_storage_account.main.id

  container_registry_id = var.container_registry_id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}