module "kubernetes" {
  source                     = "./kubernetes"
  name                       = var.name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = module.log_analytics_workspace.id
  tags                       = local.tags
}

module "cosmosdb_account" {
  source                     = "./cosmosdb_account"
  name                       = var.name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = module.log_analytics_workspace.id
  tags                       = local.tags
}

module "application_insights" {
  source                     = "./application_insights"
  name                       = var.name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = module.log_analytics_workspace.id
  tags                       = local.tags
}

module "key_vault" {
  source = "../Modules/key_vault"

  name                       = var.name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = module.log_analytics_workspace.id
  tenant_id                  = var.tenant_id
  tags                       = local.tags
}