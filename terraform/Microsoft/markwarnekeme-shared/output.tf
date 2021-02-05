output "log_analytics_workspace_id" {
  value       = module.log_analytics_workspace.id
  description = "The id of the log analytics workspace"
}

output "container_registry_id" {
  value       = module.container_registry.id
  description = "The id of the container registry"
}