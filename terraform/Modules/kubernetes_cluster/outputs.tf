output "id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "Created cluster ID"
}

output "kube_config_raw" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  description = "Created cluster raw config"
}

output "kube_admin_config_raw" {
  value       = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  description = "Created cluster ADMIN raw config"
}

output "client_key" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  description = "Created cluster client key"
}

output "client_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  description = "Created cluster client certificate"
}

output "cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  description = "Created cluster CA certificate"
}

output "host" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  description = "Created cluster host name"
}

output "cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The name of the created cluster"
}

output "cluster_resource_group_name" {
  value       = azurerm_kubernetes_cluster.aks.resource_group_name
  description = "The name of resource group of the created cluster"
}

output "cluster_node_resource_group" {
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster."
}

output "key_k8s_nodes" {
  description = "The key used to ssh the kubernetes nodes"
  value       = tls_private_key.k8s_key
}