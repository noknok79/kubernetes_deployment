resource "azurerm_subnet" "bastionsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.bastion_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_address
}
/*
resource "azurerm_nat_gateway" "bastionnatgateway" {
  name                = "${azurerm_subnet.bastionsubnet.name}-natgateway"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  #subnet_id           = azurerm_subnet.websubnet.id
  sku_name = "Standard"
}
*/
#To use this, you must use azurerm_network_security_group.websubnetnsg.id
resource "azurerm_network_security_group" "bastionsubnetnsg" {
  name                = "${azurerm_subnet.bastionsubnet.name}-nsg"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_subnet_network_security_group_association" "bastionsubnetnsgassoc" {
  depends_on                = [azurerm_network_security_rule.bastionnetsecurityruleinbound]
  subnet_id                 = azurerm_subnet.bastionsubnet.id
  network_security_group_id = azurerm_network_security_group.bastionsubnetnsg.id
  #nat_gateway_id = azurerm_nat_gateway.appnatgateway.id
}

# If the key starts with a number, you must use the colon syntax ":" instead of "="
locals {
  bastion_inbound_ports_map = {
    "100" : "22",
    "110" : "3389"
  }
}

resource "azurerm_network_security_rule" "bastionnetsecurityruleinbound" {
  for_each                    = local.bastion_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.bastionsubnetnsg.name
}
