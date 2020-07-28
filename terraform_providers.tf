#Provider Azure
provider "azurerm" {
    version = "~>2.0"
    features {}
}

#RESOURCE
resource "azurerm_resource_group" "resource" {
  name     = "HB-${var.environment}-${var.app_name}-RESOURCE"
  location = var.location

  tags = {
    description = var.description
    environment = var.environment
  }
}

#NETWORK
resource "azurerm_virtual_network" "terraformnetwork" {
    name                = "NETWORK_HBSIS"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = "HB-${var.environment}-${var.app_name}-RESOURCE"
    depends_on          = [azurerm_resource_group.resource]

    tags = {
        environment = "TerraformHB"
    }
}

#SUBNET
resource "azurerm_subnet" "terraformsubnet" {
    name                 = "SUBNET_HBSIS"
    resource_group_name  = "HB-${var.environment}-${var.app_name}-RESOURCE"
    virtual_network_name = azurerm_virtual_network.terraformnetwork.name
    address_prefixes     = ["10.0.1.0/24"]
    service_endpoints    = ["Microsoft.Sql"]

}