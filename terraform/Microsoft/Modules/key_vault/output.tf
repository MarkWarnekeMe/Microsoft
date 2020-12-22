output "id" { #Trick to wait for the sp to ad the permissions
  value = null_resource.wait_policy.id != null ? azurerm_key_vault.kv.id : azurerm_key_vault.kv.id
}

output "vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}