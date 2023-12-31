#To use this, you must use azurerm_subnet.webappsubnet.id
resource "azurerm_subnet" "websubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address
}

/*
resource "azurerm_nat_gateway" "webnatgateway" {
  name                = "${azurerm_subnet.websubnet.name}-natgateway"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  #subnet_id           = azurerm_subnet.websubnet.id
  sku_name = "Standard"
}
*/

#To use this, you must use azurerm_network_security_group.websubnetnsg.id
resource "azurerm_network_security_group" "websubnetnsg" {
  name                = "${azurerm_subnet.websubnet.name}-nsg"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_subnet_network_security_group_association" "websubnetnsgassoc" {
  depends_on = [azurerm_network_security_rule.webnetsecurityruleinbound]
  subnet_id  = azurerm_subnet.websubnet.id
  #resource_group_name = azurerm_resource_group.myrg.name
  #network_security_group_id = azurerm_network_security_group.websubnetnsg.id
  network_security_group_id = azurerm_network_security_group.websubnetnsg.id
  #nat_gateway_id = azurerm_nat_gateway.appnatgateway.id
}

# If the key starts with a number, you must use the colon syntax ":" instead of "="
locals {
  web_inbound_ports_map = {
    "100" : "80",
    "110" : "443",
    "120" : "22"
  }
}

resource "azurerm_network_security_rule" "webnetsecurityruleinbound" {
  for_each                    = local.web_inbound_ports_map
  name                        = "rule-port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrg.name
  network_security_group_name = azurerm_network_security_group.websubnetnsg.name
}

