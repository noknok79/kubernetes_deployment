resource "azurerm_subnet" "dbsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.db_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.db_subnet_address
}
/*
resource "azurerm_nat_gateway" "dbnatgateway" {
  name                = "${azurerm_subnet.dbsubnet.name}-natgateway"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  #subnet_id           = azurerm_subnet.websubnet.id
  sku_name = "Standard"
}
*/

#To use this, you must use azurerm_network_security_group.websubnetnsg.id
resource "azurerm_network_security_group" "dbsubnetnsg" {
  name                = "${azurerm_subnet.dbsubnet.name}-nsg"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_subnet_network_security_group_association" "dbsubnetnsgassoc" {
  depends_on                = [azurerm_network_security_rule.dbnetsecurityruleinbound]
  subnet_id                 = azurerm_subnet.dbsubnet.id
  network_security_group_id = azurerm_network_security_group.dbsubnetnsg.id
}

# If the key starts with a number, you must use the colon syntax ":" instead of "="
locals {
  db_inbound_ports_map = {
    "100" : "3306",
    "110" : "1433",
    "120" : "5432"
  }
}

resource "azurerm_network_security_rule" "dbnetsecurityruleinbound" {
  for_each                    = local.db_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.dbsubnetnsg.name
}
