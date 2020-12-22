terraform {
  required_providers {
    azure = {
      source  = "hasicorp/azure"
      version = "~> 2.41.0"
    }
  }
}

provider "azurerm" {
  features {}
}