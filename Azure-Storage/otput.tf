output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "file_share_name" {
  value = azurerm_storage_share.file-share.name
}

output "file_share_url" {
  value = azurerm_storage_share.file-share.url
}

output "storage_account_key" {
  value = azurerm_storage_account.storage.primary_access_key
  sensitive = true

}