resource "azurerm_subnet" "appsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.app_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_address
}

/*
resource "azurerm_nat_gateway" "appnatgateway" {
  name                = "${azurerm_subnet.appsubnet.name}-natgateway"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  #subnet_id           = azurerm_subnet.websubnet.id
  sku_name = "Standard"
}
*/

#To use this, you must use azurerm_network_security_group.websubnetnsg.id
resource "azurerm_network_security_group" "appsubnetnsg" {
  name                = "${azurerm_subnet.appsubnet.name}-nsg"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_subnet_network_security_group_association" "appsubnetnsgassoc" {
  depends_on = [azurerm_network_security_rule.appnetsecurityruleinbound]
  subnet_id  = azurerm_subnet.appsubnet.id
  #resource_group_name = azurerm_resource_group.myrg.name
  #network_security_group_id = azurerm_network_security_group.websubnetnsg.id
  network_security_group_id = azurerm_network_security_group.appsubnetnsg.id
  #nat_gateway_id = azurerm_nat_gateway.appnatgateway.id
}

# If the key starts with a number, you must use the colon syntax ":" instead of "="
locals {
  app_inbound_ports_map = {
    "100" : "80",
    "110" : "443",
    "120" : "8080",
    "130" : "22"
  }
}

resource "azurerm_network_security_rule" "appnetsecurityruleinbound" {
  for_each                    = local.app_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.appsubnetnsg.name
}
