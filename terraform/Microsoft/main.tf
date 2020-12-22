
locals {
  name     = "markwarnekeme"
  location = "germanywestcentral"
}


module "network" {
  source              = "./network"
  name                = local.name
  location            = local.location
  resource_group_name = format("%s%s", local.name, "-vnet")
}