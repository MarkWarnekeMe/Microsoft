variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "name" {
  type        = string
  description = "A name used for all resources in this module"
}

variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this module should be provisioned"
}

variable "container_registry_id" {
  type        = string
  description = "The ID of the container registry associated with this Machine Learning Workspace. Changing this forces a new resource to be created."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Required) The id of the log analytics workspace, where the data should get pushed to"
}

variable "randomId" {
  type        = string
  description = "A unique id to identify resources together"
}

variable "tags" {
  description = "A map of tags to set on every taggable resources. Default tag for resource identification are applied by default."
  default     = {}
}

variable "key_vault_sku_name" {
  type        = string
  description = "Key vault SKU"
  default     = "premium"
}

variable "sku_name" {
  type        = string
  description = "SKU/edition of the Machine Learning Workspace, possible values are `Basic` for a basic workspace or `Enterprise` for a feature rich workspace. Defaults to `Basic`"
  default     = "Basic"
}

variable "account_replication_type" {
  type        = string
  description = "Storage account account replication type"
  default     = "GRS"
}

variable "account_tier" {
  type        = string
  description = "Storage account account tier"
  default     = "Standard"
}


variable "log_categories" {
  description = "(Optional) Log Categories to enable"
  type = list(object({
    name           = string
    enabled        = bool
    retention_days = number
  }))
  default = [{
    name           = "AmlComputeClusterEvent"
    enabled        = true
    retention_days = 7
    },
    {
      name           = "AmlComputeClusterNodeEvent"
      enabled        = true
      retention_days = 7
    },
    {
      name           = "AmlComputeJobEvent"
      enabled        = true
      retention_days = 7
    },
    {
      name           = "AmlComputeCpuGpuUtilization"
      enabled        = true
      retention_days = 7
    },
    {
      name           = "AmlRunStatusChangedEvent"
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
