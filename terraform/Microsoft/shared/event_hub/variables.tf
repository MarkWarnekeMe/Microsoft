
variable "name" {
  description = "Name of the resource"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Location of the resources"
}

variable "log_analytics_workspace_id" {
  description = "(Required) The id of the log analytics workspace, where the data should get pushed to"
}


variable "tags" {
  description = "Additional tags for the resources"
  default     = {}
}

variable "partition_count" {
  default     = 2
  description = "(Required) Specifies the current number of shards on the Event Hub. Changing this forces a new resource to be created."
}

variable "message_retention" {
  default     = 1
  description = "(Required) Specifies the number of days to retain the events for this Event Hub."
}

variable "sku" {
  description = " (Optional) Defines which tier to use. Valid options are Basic and Standard."
  default     = "Standard"
}


variable "capacity" {
  description = "(Optional) Specifies the Capacity / Throughput Units for a Standard SKU namespace. Valid values range from 1 - 20."
  default     = 1
}


# variable "auto_inflate_enabled" {
#   description = "(Optional) Is Auto Inflate enabled for the EventHub Namespace?"
#   default     = true
# }

variable "log_categories" {
  description = "(Optional) Log Categories to enable"
  type = list(object({
    name           = string
    enabled        = bool
    retention_days = number
  }))
  default = [{
    name           = "OperationalLogs"
    enabled        = true
    retention_days = 7
    },
    {
      name           = "AutoScaleLogs"
      enabled        = true
      retention_days = 7
    },
    {
      name           = "ArchiveLogs"
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
