# Using Existing Resource Group
data "azurerm_resource_group" "existing_rg" {
  name = "rg-qa-group" 
}


# API Connection for Azure Container Instances (ACI)
resource "azurerm_api_connection" "aci_connection" {
  name                = "aci"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  # Use the ARM resource ID of the "azurecontainerinstance" managed API
  managed_api_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.Web/locations/${data.azurerm_resource_group.existing_rg.location}/managedApis/aci"

  parameter_values = {
    "token:TenantId"  = data.azurerm_client_config.current.tenant_id
    "token:grantType" = "client_credentials" # Use Service Principal authentication
    "token:clientId"  = "716XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    "token:clientSecret" = "IbL8XXXXXXXXXXXXXXXXXXXXXXXXXXX"
  }

  lifecycle {
    ignore_changes = [
      parameter_values
    ]
  }

  tags = {
    environment = "qa"
  }
}

# Logic App Deployment using ARM Template
resource "azurerm_resource_group_template_deployment" "logic_app" {
  name                = "logic-app-deployment1"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  deployment_mode     = "Incremental"
  template_content    = file("template.json")
  parameters_content  = jsonencode({
    "logicAppName" = {
      value = "logic-app-jail01"
    },
    "containerGroups___encodeURIComponent__containergroup001____externalid" = {
      value = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.azurerm_resource_group.existing_rg.name}/providers/Microsoft.ContainerInstance/containerGroups/containergroup001"
    },
    "connections_aci_externalid" = {
      value = azurerm_api_connection.aci_connection.id
    }
  })
}

# Get current Azure subscription and tenant details
data "azurerm_client_config" "current" {}

output "logic_app_webhook_url" {
  value = jsondecode(azurerm_resource_group_template_deployment.logic_app.output_content)["logicAppWebhookUrl"]
}
