
variable "name" {
  description = "Name of the resource"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Location of the resources"
}

variable "tags" {
  description = "Additional tags for the resources"
  default     = {}
}

variable "tenant_id" {
  description = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
}

variable "log_analytics_workspace_id" {
  description = "Id of the log analytics workspace"
}