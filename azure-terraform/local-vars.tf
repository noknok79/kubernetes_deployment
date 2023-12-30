locals {
  owners               = var.business_division
  environment          = var.environment
  resource_name_prefix = "${var.environment}-${var.business_division}"
  common_tags = {
    owners      = local.owners,
    environment = local.environment
  }
}

#When the keys are numeric, it must use ":" instead of "="




