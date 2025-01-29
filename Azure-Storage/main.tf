# Using Existing Resource Group
data "azurerm_resource_group" "existing_rg" {
  name = "rg-qa-group" 
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name     
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = data.azurerm_resource_group.existing_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "qa"
  }
}


resource "azurerm_storage_share" "file-share" {
  name                 = var.file_share_name        
  storage_account_id   = azurerm_storage_account.storage.id
  quota                = 100                           
}
