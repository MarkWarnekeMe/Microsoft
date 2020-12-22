terraform {
  required_providers {
    azure = {
      source  = "hasicorp/azurerm"
      version = "~> 2.41.0"
    }
  }
}

provider "azurerm" {
  features {}
}