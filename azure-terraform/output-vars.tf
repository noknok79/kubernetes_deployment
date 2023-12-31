/*
#Output for Virtual Network
output "virtual_network_name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.vnet.name
}

output "virtual_network_id" {
  description = "Virtual Network address space"
  value       = azurerm_virtual_network.vnet.id
}

#Output for Web Subnet
output "web_subnet_name" {
  description = "WebTier Subnet name"
  value       = azurerm_subnet.websubnet.name
}

output "web_subnet_id" {
  description = "WebTier Subnet id"
  value       = azurerm_subnet.websubnet.id
}

output "web_subnet_nsg_name" {
  description = "WebTier Subnet NSG"
  value       = azurerm_network_security_group.websubnetnsg.name
}

output "web_subnet_nsg_id" {
  description = "WebTier Subnet NSG id"
  value       = azurerm_network_security_group.websubnetnsg.id
}
*/

/*
#Ouput for App Subnet
output "app_subnet_name" {
  description = "AppTier Subnet name"
  value       = azurerm_subnet.appsubnet.name
}

output "app_subnet_id" {
  description = "AppTier Subnet id"
  value       = azurerm_subnet.appsubnet.id
}


#Output for DB Subnet
output "db_subnet_name" {
  description = "DBTier Subnet name"
  value       = azurerm_subnet.dbsubnet.name
}

output "db_subnet_id" {
  description = "DBTier Subnet id"
  value       = azurerm_subnet.dbsubnet.id
}



#Output for Bastion Subnet
output "bastion_subnet_name" {
  description = "Bastion Subnet name"
  value       = azurerm_subnet.bastionsubnet.name
}

output "bastion_subnet_id" {
  description = "Bastion Subnet id"
  value       = azurerm_subnet.bastionsubnet.id
}

#Output for Web Subnet NSG Inbound Rule
output "webnetsecurityruleinbound" {
  description = "WebTier Subnet NSG Inbound Rule"
  value       = azurerm_network_security_rule.webnetsecurityruleinbound
}

#Output for App Subnet NSG Inbound Rule
output "appnetsecurityruleinbound" {
  description = "AppTier Subnet NSG Inbound Rule"
  value       = azurerm_network_security_rule.appnetsecurityruleinbound
}

#Output for DB Subnet NSG Inbound Rule
output "dbnetsecurityruleinbound" {
  description = "DBTier Subnet NSG Inbound Rule"
  value       = azurerm_network_security_rule.dbnetsecurityruleinbound
}

#Output for Bastion Subnet NSG Inbound Rule
output "bastionnetsecurityruleinbound" {
  description = "Bastion Subnet NSG Inbound Rule"
  value       = azurerm_network_security_rule.bastionnetsecurityruleinbound
}
*/

/*
#Output for Web Subnet NSG Outbound Rule
output "webnetsecurityruleoutbound" {
  description = "WebTier Subnet NSG Outbound Rule"
  value       = azurerm_network_security_rule.webnetsecurityruleoutbound
}

#Output for App Subnet NSG Outbound Rule
output "appnetsecurityruleoutbound" {
  description = "AppTier Subnet NSG Outbound Rule"
  value       = azurerm_network_security_rule.appnetsecurityruleoutbound
}

#Output for DB Subnet NSG Outbound Rule
output "dbnetsecurityruleoutbound" {
  description = "DBTier Subnet NSG Outbound Rule"
  value       = azurerm_network_security_rule.dbnetsecurityruleoutbound
}

#Output for Bastion Subnet NSG Outbound Rule
output "bastionnetsecurityruleoutbound" {
  description = "Bastion Subnet NSG Outbound Rule"
  value       = azurerm_network_security_rule.bastionnetsecurityruleoutbound
}

*/

output "web_linuxvm_public_ip"{
  description = "Web Linux VM Public IP"
  value = [azurerm_public_ip.web_linux_vm_public_ip.ip_address]
}

output "web_linuxvm_network_interfaces"{
  description = "Web Linux VM Network Interface ID"
  value = [azurerm_network_interface.web_linuxvm_nic.id]  
}


output "web_linuxvm_network_interfaces_private_ip" {
  description = "Web Linux VM Network Interface ID Private IP"
  value = [azurerm_network_interface.web_linuxvm_nic.private_ip_address]  
}

output "web_linux_public_ip_address"{
  description = "Web Linux VM Public IP Address"
  value = [azurerm_linux_virtual_machine.web-linuxvm.public_ip_address]
}

output "web_linux_prive_ip_address"{
  description = "Web Linux VM Private IP Address"
  value = [azurerm_linux_virtual_machine.web-linuxvm.private_ip_address]
}

output "web_linux_virtual_machine_id_128"{
  description = "Web Linux VM ID"
  value = [azurerm_linux_virtual_machine.web-linuxvm.virtual_machine_id]
}

output "web_linux_virtual_machine_id"{
  description = "Web Linux VM ID"
  value = [azurerm_linux_virtual_machine.web-linuxvm.id]
}
