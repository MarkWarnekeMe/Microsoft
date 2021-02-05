
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