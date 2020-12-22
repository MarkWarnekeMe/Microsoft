variable "location" {
  type        = string
  description = "The Azure location where all resources should be created"
}

variable "name" {
  type        = string
  description = "A name used for the container registry"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the ACR will be created"
}

variable "log_analytics_workspace_id" {
  description = "The id of the log analytics workspace, where all the diagnostics data should get stored in"
  type        = string
}

variable "sku" {
  default     = "Standard"
  description = "The SKU of the container registry"
}

variable "geo_rep_locations" {
  type        = list(string)
  default     = null
  description = "Locations for Geo Replication"
}

variable "admin_enabled" {
  type        = string
  default     = "true"
  description = "The admin_enabled flag to specify whether the admin user is enabled, needed for e.g. ACI"
}

variable "log_categories" {
  description = "(Optional) Log Categories to enable"
  type = list(object({
    name           = string
    enabled        = bool
    retention_days = number
  }))
  default = [{
    name           = "ContainerRegistryLoginEvents"
    enabled        = true
    retention_days = 7
    }, {
    name           = "ContainerRegistryRepositoryEvents"
    enabled        = true
    retention_days = 7
  }]
}

variable "metric_categories" {
  description = "(Optional) Metric Categories to enable"
  type = list(object({
    name           = string
    enabled        = bool
    retention_days = number
  }))
  default = [{
    name           = "AllMetrics"
    enabled        = true
    retention_days = 7
  }]
}

variable "tags" {
  description = "A map of tags to set on every taggable resources. Default tag for resource identification are applied by default."
  default     = {}
}
