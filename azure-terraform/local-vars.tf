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
    "140" : "80",
    "240" : "443",
    "340" : "22"
  }
}

locals {
  app_inboud_port_map = {
    "110" : "80",
    "210" : "443",
    "360" : "22",
    "410" : "8080"
    
  }
}

locals {
  db_inboud_port_map = {
    "120" : "3306",
    "220" : "1433",
    "320" : "5432"
  }
}

locals {
  bastion_inboud_port_map = {
    "230" : "3389",
    "350" : "22"
  }
}