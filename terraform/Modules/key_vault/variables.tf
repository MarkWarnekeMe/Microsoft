variable "name" {
  description = "(Required) Specifies the name of the Key Vault. Changing this forces a new resource to be created"
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created"
}

variable "sku_name" {
  description = "(Optional) The Name of the SKU used for this Key Vault. Possible values are standard and premium"
  default     = "standard"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "(Required) The id of the log analytics workspace, where the data should get pushed to"
}

variable "log_categories" {
  description = "(Optional) Log Categories to enable"
  type = list(object({
    name           = string
    enabled        = bool
    retention_days = number
  }))
  default = [{
    name           = "AuditEvent"
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
