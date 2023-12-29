
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