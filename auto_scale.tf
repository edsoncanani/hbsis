resource "azurerm_virtual_machine_scale_set" "HB-TerraformHB-HBSIS-COMPUTER {
  # ...
}

resource "azurerm_monitor_autoscale_setting" "HB-TerraformHB-HBSIS-COMPUTER" {
  name                = "AutoscaleSetting"
  resource_group_name = azurerm_resource_group.resource.name
  location            = azurerm_resource_group.resource.location
  target_resource_id  = azurerm_virtual_machine_scale_set.HB-TerraformHB-HBSIS-COMPUTER.id

  profile {
    name = "AutoScale"

    capacity {
      default = 1
      minimum = 1
      maximum = 2
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_virtual_machine_scale_set.HB-TerraformHB-HBSIS-COMPUTER.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_virtual_machine_scale_set.HB-TerraformHB-HBSIS-COMPUTER.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}