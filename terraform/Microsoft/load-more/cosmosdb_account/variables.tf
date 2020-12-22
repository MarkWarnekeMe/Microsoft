variable "location" {
  type        = string
  description = "The Azure location where all resources should be created"
}

variable "name" {
  type        = string
  description = "A name used for the application insights"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the application insights will be created"
}


variable "log_analytics_workspace_id" {
  description = "The id of the log analytics workspace, where all the diagnostics data should get stored in"
  type        = string
}

variable "tags" {
  description = "A map of tags to set on every taggable resources. Default tag for resource identification are applied by default."
  default     = {}
}

variable "log_categories" {
  description = "(Optional) Log Categories to enable"
  type = list(object({
    name           = string
    enabled        = bool
    retention_days = number
  }))
  default = [{
    name           = "DataPlaneRequests"
    enabled        = true
    retention_days = 7
    },
    {
      name           = "QueryRuntimeStatistics"
      enabled        = true
      retention_days = 7
    },
    {
      name           = "PartitionKeyStatistics"
      enabled        = true
      retention_days = 7
    },
    {
      name           = "PartitionKeyRUConsumption"
      enabled        = true
      retention_days = 7
    },
    {
      name           = "ControlPlaneRequests"
      enabled        = true
      retention_days = 7
    },
    {
      name           = "Requests"
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
