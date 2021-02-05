terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.41.0"
    }
    github = {
      source  = "integrations/github"
      # 4.3.1 is broken for personal account users
      version = "4.3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.9.1"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.10"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

data "azurerm_key_vault" "existing" {
  # From variables.sh
  name                = var.resource_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "markwarnekeme_github_flux" {
  name         = "markwarnekeme-github-flux"
  key_vault_id = data.azurerm_key_vault.existing.id
}

provider "github" {
  token        = data.azurerm_key_vault_secret.markwarnekeme_github_flux.value
  organization = "MarkWarnekeMe"
  version      = "=2.4.1"
}

provider "kubernetes" {
  host                   = module.load-more.kubernetes_cluster.kube_admin_config.0.host
  client_certificate     = base64decode(module.load-more.kubernetes_cluster.kube_admin_config.0.client_certificate)
  client_key             = base64decode(module.load-more.kubernetes_cluster.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(module.load-more.kubernetes_cluster.kube_admin_config.0.cluster_ca_certificate)
  version = "=2.0.2"
}




