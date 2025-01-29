data "terraform_remote_state" "logic-app" {
  backend = "local"
  config = {
    path = "../logic-app/terraform.tfstate"
  }
}

#resource "azurerm_resource_group" "example" {
 # name     = var.resource_group_name
  #location = var.location
#}

data "azurerm_resource_group" "existing_rg" {
  name = "rg-qa-group" 
}

resource "azurerm_container_registry" "acr" {
  name                = var.registry_name
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  location            = data.azurerm_resource_group.existing_rg.location
  sku                 = "Standard"
  admin_enabled       = true
}
 
resource "azurerm_container_registry_webhook" "webhook" {
  name                = var.webhook_name
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  registry_name       = azurerm_container_registry.acr.name
  location            = data.azurerm_resource_group.existing_rg.location
  
  service_uri         = data.terraform_remote_state.logic-app.outputs.logic_app_webhook_url.value
  status              = "enabled"
  actions             = ["push"]
}