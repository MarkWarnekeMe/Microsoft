
variable "name" {
  description = "Name of the resource"
  value       = "load-more"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  value       = "load-more"
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