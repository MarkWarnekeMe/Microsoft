resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.resource_group_name
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

module "log_analytics_workspace" {
  source = "./log_analytics_workspace"

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
}


module "container_registry" {
  source = "./container_registry"

  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = module.log_analytics_workspace.id
}