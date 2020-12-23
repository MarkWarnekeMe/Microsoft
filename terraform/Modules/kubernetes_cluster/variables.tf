variable "wait_for_it" {
  description = "trick to do depends_on on mudules, currently not supported by terraform"
  default     = []
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Kubernetes. Changing this forces a new resource to be created"
}

variable "name" {
  type        = string
  description = "Name used for all resources in this module"
}

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  description = "CIDR range where kubernetes API can be accesseded from"
  default     = ["0.0.0.0/0"] #everywhere
}

variable "aks_subnet_id" {
  type        = string
  description = "The subnet identifier AKS should join to"
}

variable "aks_aci_subnet_id" {
  type        = string
  description = " (Optional) The subnet name for the virtual nodes to run. This is required when aci_connector_linux enabled argument is set to true."
}

variable "enable_auto_scaling" {
  default     = false
  description = "Enable autoscaling of the default nodepool"
}

variable "default_node_pool_name" {
  default     = "system"
  description = "Name of the default nodepoll"
}

variable "default_node_pool_disk_size" {
  default     = 32
  description = "Size of the disk for the default nodepool"
}

variable "default_node_pool_nodes_taints" {
  default     = null
  description = "Node taint that will be applied to the nodes taints"
}

variable "default_node_pool_nodes_max_pods" {
  default     = null
  description = "Max pods per node (one pod request 1 ip)"
}

variable "aks_default_nodepool_node_count" {
  type        = number
  description = "The number of nodes in default node pool for AKS"
}

variable "aks_default_nodepool_nodes_max" {
  type        = number
  description = "The max number of nodes in default node pool for AKS"
  default     = 30
}

variable "aks_default_nodepool_node_size" {
  type        = string
  description = "Node size in default node pool for AKS"
}

variable "tags" {
  description = "A map of tags to set on every taggable resources. Default tag for resource identification are applied by default."
  default     = {}
}

variable "network_profile" {
  default = {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }
  description = "Network profile that will be used with AKS"
}

variable "kubernetes_version" {
  default     = "1.18"
  description = "Version of kubernetes used with aks"
}

variable "aks_admin_username" {
  default     = "k8s"
  description = "User profile name to ssh the workers"
}

variable "kubernetes_rbac_enabled" {
  type        = bool
  default     = true
  description = "Is Role Based Access Control for AKS Enabled?"
}

variable "kubernetes_rbac_aad_enabled" {
  type        = bool
  default     = false
  description = "Is AKS Role Based Access Control integration with AAD Enabled?"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Resource id of the log analytics workspace"
}

variable "logs" {
  description = "List of log categories to log."
  type        = list(string)
  default     = ["kube-apiserver", "kube-audit", "kube-controller-manager", "kube-scheduler", "cluster-autoscaler"]
}

variable "metric" {
  default = {
    category = "AllMetrics"
    enabled  = true
  }

  description = "Metric definition of the log workspace"
}
