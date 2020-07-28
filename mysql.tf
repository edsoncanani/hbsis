resource "azurerm_mysql_server" "webhbsisdb" {
  name                = "webhbsisdb"
  location            = "eastus"
  resource_group_name = "HB-${var.environment}-${var.app_name}-RESOURCE"

  administrator_login          = "hbsis"
  administrator_login_password = "L@ndsc@P3"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  ssl_enforcement_enabled           = true
  public_network_access_enabled     = true

  depends_on          = [azurerm_resource_group.resource]
}

resource "azurerm_mysql_database" "webhbsisdb" {
  name                = "hbsisdb"
  resource_group_name = "HB-${var.environment}-${var.app_name}-RESOURCE"
  server_name         = azurerm_mysql_server.webhbsisdb.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_virtual_network_rule" "mysqlsubnet" {
  name                = "mysqlsubnet"
  resource_group_name = "HB-${var.environment}-${var.app_name}-RESOURCE"
  server_name         = azurerm_mysql_server.webhbsisdb.name
  subnet_id           = azurerm_subnet.terraformsubnet.id
}