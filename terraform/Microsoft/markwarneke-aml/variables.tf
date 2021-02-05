
variable "name" {
  description = "Name of the resource"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Location of the resources"
}

variable "randomId" {
  description = "A random id to identify the resources"
}

variable "container_registry_id" {
  description = "The ID of the container registry associated with this Machine Learning Workspace. Changing this forces a new resource to be created."
}

variable "log_analytics_workspace_id" {
  description = "(Required) The id of the log analytics workspace, where the data should get pushed to"
}

variable "tags" {
  description = "Additional tags for the resources"
  default     = {}
}

