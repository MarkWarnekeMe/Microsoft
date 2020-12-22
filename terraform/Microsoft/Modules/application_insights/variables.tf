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

variable "application_type" {
  description = "(Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created."
}

variable "daily_data_cap_in_gb" {
  description = "(Optional) Specifies the Application Insights component daily data volume cap in GB."
  default     = 1
}

variable "tags" {
  description = "A map of tags to set on every taggable resources. Default tag for resource identification are applied by default."
  default     = {}
}
