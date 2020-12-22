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

variable "tags" {
  description = "A map of tags to set on every taggable resources. Default tag for resource identification are applied by default."
  default     = {}
}

# ================ DEFAULTS ================

variable "sku" {
  type        = string
  description = "SKU for the log analtyics workspace"
  default     = "PerGB2018"
}

variable "retention_in_days" {
  type        = number
  description = "(Optional) The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  default     = 30
}

variable "daily_quota_gb" {
  type        = number
  description = "(Optional) The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted."
  default     = 1
}
