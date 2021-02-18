
locals {
  name     = "markwarnekeme"
  location = "germanywestcentral"
}

variable "tenant_id" {
  description = "Based on env see `secrets.sh`"
}

module "network" {
  source = "./markwarnekeme-vnet"

  name                = local.name
  location            = local.location
  resource_group_name = format("%s%s", local.name, "-vnet")
}

module "shared" {
  source = "./markwarnekeme-shared"

  name                = local.name
  location            = local.location
  resource_group_name = format("%s%s", local.name, "-shared")
}


module "load-more" {
  source = "./load-more"

  name                = "load-more"
  location            = local.location
  resource_group_name = format("%s%s", "load-more", "")

  log_analytics_workspace_id = module.shared.log_analytics_workspace_id
  aks_subnet_id              = module.network.backend_subnet_id
  aks_aci_subnet_id          = module.network.backend_virtual_node_subnet_id

  aks_default_nodepool_node_size  = "Standard_D2s_v3"
  aks_default_nodepool_node_count = 3
  kubernetes_version              = "1.18.0"
}

module "aml" {

  source = "./markwarneke-aml"

  name                = format("%s%s", local.name, "aml")
  location            = "westeurope" # TODO: 'canadacentral,centralindia,northcentralus,uksouth,westus,centralus,eastasia,japaneast,eastus,northeurope,koreacentral,brazilsouth,francecentral,australiaeast,eastus2,westus2,westcentralus,southeastasia,westeurope,southcentralus
  resource_group_name = format("%s%s", local.name, "-aml")

  container_registry_id      = module.shared.container_registry_id
  log_analytics_workspace_id = module.shared.log_analytics_workspace_id
}
