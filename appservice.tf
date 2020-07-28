#APP Services

#MAQUINA
resource "azurerm_app_service_plan" "computer" {
  name                = "HB-${var.environment}-${var.app_name}-COMPUTER"
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    description = var.description
    environment = var.environment  
  }
}

#SERVICO
resource "azurerm_app_service" "service" {
  name                = "HB-${var.environment}-${var.app_name}-SERVICE"
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  app_service_plan_id = azurerm_app_service_plan.computer.id

  site_config {
    linux_fx_version = "PHP|7.2"
  }

  tags = {
    description = var.description
    environment = var.environment
  }
}