resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.main.name
  }

  byte_length = 10
}

locals {
  fixed_tags = {
    id        = random_id.randomId.hex
    terraform = "true"
  }

  tags = merge(var.tags, local.fixed_tags)
}

module "kubernetes_cluster" {
  source              = "../../Modules/kubernetes_cluster"
  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name


  kubernetes_version = var.kubernetes_version

  aks_default_nodepool_node_size  = var.aks_default_nodepool_node_size
  aks_default_nodepool_node_count = var.aks_default_nodepool_node_count

  log_analytics_workspace_id = var.log_analytics_workspace_id

  aks_subnet_id     = var.aks_subnet_id
  aks_aci_subnet_id = var.aks_aci_subnet_id

  tags = local.tags
}

module "cosmosdb_account" {
  source = "../../Modules/cosmosdb_account"

  name                       = var.name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  tags                       = local.tags
}

module "application_insights" {
  source = "../../Modules/application_insights"

  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "web"
  tags                = local.tags
}

module "key_vault" {
  source = "../../Modules/key_vault"

  name                       = var.name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  tenant_id                  = var.tenant_id
  tags                       = local.tags
}