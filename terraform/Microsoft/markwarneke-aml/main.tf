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

module "machine_learning_workspace" {
  source = "../../Modules/machine_learning_workspace"

  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  randomId                   = random_id.randomId.hex
  container_registry_id      = var.container_registry_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  tags = local.tags
}