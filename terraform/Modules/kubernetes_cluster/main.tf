
# Deploys AKS
resource "azurerm_kubernetes_cluster" "aks" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  dns_prefix                      = var.name
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges
  # enable_pod_security_policy = true

  node_resource_group = format("%s%s", var.name, "-kaas")

  default_node_pool {
    name                = var.default_node_pool_name
    enable_auto_scaling = var.enable_auto_scaling
    node_count          = var.aks_default_nodepool_node_count
    min_count           = var.enable_auto_scaling ? var.aks_default_nodepool_nodes_min : null
    max_count           = var.enable_auto_scaling ? var.aks_default_nodepool_nodes_max : null
    vm_size             = var.aks_default_nodepool_node_size
    os_disk_size_gb     = var.default_node_pool_disk_size
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = var.aks_subnet_id
    node_taints         = var.default_node_pool_nodes_taints
    max_pods            = var.default_node_pool_nodes_max_pods
    orchestrator_version = var.kubernetes_version
  }

  identity {
    type = "SystemAssigned"
  }



  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }

    azure_policy {
      enabled = true
    }

    aci_connector_linux {
      enabled     = false # Issue #23
      subnet_name = var.aks_aci_subnet_id

    }

    kube_dashboard {
      enabled = false
    }
  }




  dynamic "network_profile" {
    for_each = lookup(var.network_profile, "network_plugin", null) == "azure" ? [1] : []
    content {
      network_plugin    = lookup(var.network_profile, "network_plugin", null)
      network_policy    = lookup(var.network_profile, "network_policy", null)
      load_balancer_sku = lookup(var.network_profile, "load_balancer_sku", null)
      outbound_type     = lookup(var.network_profile, "outbound_type", "loadBalancer")
    }
  }
  dynamic "network_profile" {
    for_each = lookup(var.network_profile, "network_plugin", null) == "kubenet" ? [1] : []
    content {
      network_plugin     = lookup(var.network_profile, "network_plugin", null)
      network_policy     = lookup(var.network_profile, "network_policy", null)
      dns_service_ip     = lookup(var.network_profile, "dns_service_ip", null)
      docker_bridge_cidr = lookup(var.network_profile, "docker_bridge_cidr", null)
      service_cidr       = lookup(var.network_profile, "service_cidr", null)
      pod_cidr           = lookup(var.network_profile, "pod_cidr", null)
      load_balancer_sku  = lookup(var.network_profile, "load_balancer_sku", null)
    }
  }



  kubernetes_version = var.kubernetes_version

  role_based_access_control {
    enabled = var.kubernetes_rbac_enabled

    azure_active_directory {
      managed = true
    }
  }


  tags = var.tags

  lifecycle {
    ignore_changes = [
      default_node_pool.0.node_count,
      default_node_pool.0.min_count,
      default_node_pool.0.max_count
    ]
  }

}

locals {
  aks_logs_disabled = setsubtract(["cluster-autoscaler", "kube-apiserver", "kube-audit", "kube-audit-admin", "kube-controller-manager", "kube-scheduler", "guard"], var.logs)
}

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name               = azurerm_kubernetes_cluster.aks.name
  target_resource_id = azurerm_kubernetes_cluster.aks.id

  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = var.logs
    content {
      category = log.value
      enabled  = true

      retention_policy {
        enabled = false
        days    = 7
      }
    }
  }

  dynamic "log" {
    for_each = local.aks_logs_disabled
    content {
      category = log.key
      enabled  = false

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  metric {
    category = lookup(var.metric, "category", null)
    enabled  = lookup(var.metric, "enabled", false)

    retention_policy {
      enabled = false
      days    = 7
    }
  }
}
