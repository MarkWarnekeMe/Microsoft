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

///////////// LOGS
variable "solution_plan_map" {
  description = "Solutions applied to the Workspace analytic environment"
  type        = map(map(string))
}

# ================ DEFAULTS ================

variable "sku" {
  type        = string
  description = "SKU for the log analtyics workspace"
  default     = "PerGB2018"
}