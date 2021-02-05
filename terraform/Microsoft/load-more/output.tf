output "kubernetes_cluster" {
  value       = module.kubernetes_cluster
  description = "The kubernetes cluster"
}

output "cosmosdb_account" {
  value       = module.cosmosdb_account
  description = "The cosmosdb account"
}

output "application_insights" {
  value       = module.application_insights
  description = "The application insights"
}

output "key_vault" {
  value       = module.key_vault
  description = "The key vault"
}