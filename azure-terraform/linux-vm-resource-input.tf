

#This resources is using existing subnet "webappsubnet" from web-subnet-nsg-input.tf
#And resource group of "myrg" from resource-group-input.tf

#To use this, you must use azurerm_public_ip.web_linux_vm_public_i.id
resource "azurerm_public_ip" "web_linux_vm_public_ip" {
  name                = "${local.resource_name_prefix}-linux_vm_public_ip"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "web1-vm-${random_string.myrandomstring.id}"
  tags                = local.common_tags
}

#To use this, you must use azurerm_public_ip.web_linuxvm_nic.id
resource "azurerm_network_interface" "web_linuxvm_nic" {
  name                = "${local.resource_name_prefix}-web-linuxvm_nic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  #IP Configuration can have more than one IP address, and as much as needed
  ip_configuration {
    name                          = "web-linuxvm-ipconfig"
    subnet_id                     = azurerm_subnet.websubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_linux_vm_public_ip.id
  }

  tags = local.common_tags

}

resource "azurerm_network_security_group" "weblinuxsubnetnsg" {
  name                = "${azurerm_network_interface.web_linuxvm_nic.name}-nsg"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_network_interface_security_group_association" "weblinuxsubnetnsgassoc" {
  depends_on                = [azurerm_network_security_rule.weblinuxnetsecurityruleinbound]
  network_interface_id      = azurerm_network_interface.web_linuxvm_nic.id
  #subnet_id                 = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.weblinuxsubnetnsg.id
}

# If the key starts with a number, you must use the colon syntax ":" instead of "="
locals {
  web_inbound_ports_map = {
    "100" : "80",
    "110" : "443",
    "120" : "22"
  }
}

resource "azurerm_network_security_rule" "weblinuxnetsecurityruleinbound" {
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
  network_security_group_name = azurerm_network_security_group.weblinuxsubnetnsg.name
}
