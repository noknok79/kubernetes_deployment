locals {
  owners               = var.business_division
  environment          = var.environment
  resource_name_prefix = "${azurerm_resource_group.myrg.name}-${var.environment}-${var.business_division}"
  common_tags = {
    owners      = local.owners,
    environment = local.environment
  }
}

#When the keys are numeric, it must use ":" instead of "="
locals {
  web_inbound_port_map = {
    "100" : "80",
    "200" : "443",
    "300" : "22"
  }
}

locals {
  app_inboud_port_map = {
    "110" : "80",
    "210" : "443",
    #"310" : "8080"
    #"410" : "22"
  }
}

locals {
  db_inboud_port_map = {
    "120" : "3306",
    #"220" : "1433"
    "320" : "5432"
  }
}

locals {
  bastion_inboud_port_map = {
    "130" : "22"
    "230" : "3389"
  }
}