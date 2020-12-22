
locals {
  name     = "markwarnekeme"
  location = "westeurope"
}


module "network" {
  source              = "./network"
  name                = local.name
  location            = local.location
  resource_group_name = local.name + "-vnet"
}