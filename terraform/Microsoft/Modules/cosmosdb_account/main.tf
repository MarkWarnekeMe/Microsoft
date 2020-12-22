
resource "azurerm_cosmosdb_account" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  # geo_location {
  #   location          = var.failover_location
  #   failover_priority = 1
  # }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  tags = var.tags
}
