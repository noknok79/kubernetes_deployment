#To use this, you must use azurerm_subnet.webappsubnet.id
resource "azurerm_subnet" "websubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address
}

resource "azurerm_subnet" "appsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.app_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_address
}

resource "azurerm_subnet" "dbsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.db_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.db_subnet_address
}

resource "azurerm_subnet" "bastionsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.bastion_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_address
}

resource "azurerm_nat_gateway" "mynatgateway" {
  name                = "${azurerm_subnet.websubnet.name}-natgateway"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  #subnet_id           = azurerm_subnet.websubnet.id
  sku_name = "Standard"
}


#To use this, you must use azurerm_network_security_group.websubnetnsg.id
resource "azurerm_network_security_group" "websubnetnsg" {
  name                = "${azurerm_subnet.websubnet.name}-nsg"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrandomrg.name
}

resource "azurerm_subnet_nat_gateway_association" "websubnetnsgassoc" {
  depends_on = [azurerm_network_security_rule.webnetsecurityruleinbound]
  subnet_id  = azurerm_subnet.websubnet.id
  #resource_group_name = azurerm_resource_group.myrg.name
  #network_security_group_id = azurerm_network_security_group.websubnetnsg.id
  #network_security_group_id = azurerm_network_security_group.websubnetnsg.id
  nat_gateway_id = azurerm_nat_gateway.mynatgateway.id

}

resource "azurerm_network_security_rule" "webnetsecurityruleinbound" {
  for_each                    = local.web_inbound_port_map
  name                        = "rule-port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrandomrg.name
  network_security_group_name = azurerm_network_security_group.websubnetnsg.name
}

resource "azurerm_network_security_rule" "appnetsecurityruleinbound" {
  for_each                    = local.app_inboud_port_map
  name                        = "rule-port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrandomrg.name
  network_security_group_name = azurerm_network_security_group.websubnetnsg.name
}

resource "azurerm_network_security_rule" "dbnetsecurityruleinbound" {
  for_each                    = local.db_inboud_port_map
  name                        = "rule-port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrandomrg.name
  network_security_group_name = azurerm_network_security_group.websubnetnsg.name
}

resource "azurerm_network_security_rule" "bastionnetsecurityruleinbound" {
  for_each                    = local.bastion_inboud_port_map
  name                        = "rule-port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrandomrg.name
  network_security_group_name = azurerm_network_security_group.websubnetnsg.name
}
