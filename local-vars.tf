locals {
  owners               = var.business_division
  environment          = var.environment
  resource_name_prefix = "${var.resouce_group.location}-${var.business_division}-${var.environment}"
  common_tags = {
    owners      = local.owners,
    environment = local.environment
  }
}

#When the keys are numeric, it must use ":" instead of "="
locals {
  web_inbound_port_map = {
    "100" : "80",
    "110" : "443",
    "120" : "22"
  }
}

locals {
  app_inboud_port_map = {
    "100" : "80",
    "110" : "443",
    "120" : "8080"
    "130" : "22"
  }
}

locals {
  db_inboud_port_map = {
    "100" : "3306",
    "110" : "1433"
    "120" : "5432"
  }
}

locals {
  bastion_inboud_port_map = {
    "100" : "22"
    "110" : "3389"
  }
}