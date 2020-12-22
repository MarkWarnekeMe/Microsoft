
locals {
  name     = "markwarnekeme"
  location = "germanywestcentral"
}

variable "tenant_id" {
  description = "Based on env see `secrets.sh`"
}

module "network" {
  source              = "./vnet"
  name                = local.name
  location            = local.location
  resource_group_name = format("%s%s", local.name, "-vnet")
}

module "shared" {
  source              = "./shared"
  name                = local.name
  location            = local.location
  resource_group_name = format("%s%s", local.name, "-shared")

  # Used from TF_VAR_tenant_id based on `secrets.sh`
  tenant_id = var.tenant_id
}


module "load-more" {
  source = "./load-more"

  name                = "load-more"
  resource_group_name = format("%s%s", "load-more", "-dev")

  location = local.location

  # Used from TF_VAR_tenant_id based on `secrets.sh`
  tenant_id = var.tenant_id

  log_analytics_workspace_id = module.shared.log_analytics_workspace_id
}