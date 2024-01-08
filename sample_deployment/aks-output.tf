output "resource_group_location" {
  value = data.azurerm_resource_group.aks_rg.location
}

output "resource_group_id" {
  value = data.azurerm_resource_group.aks_rg.id
}

output "resource_group_name" {
  value = data.azurerm_resource_group.aks_rg.name
}

output aks-version {
  value       = data.azurerm_kubernetes_versions.curent.version
}

output "latest_version" {
  value = data.azurerm_kubernetes_versions.curent.latest_version
}

/*
output "azure_ad_group_id" {
  value = data.azurerm_azuread_group.aks-ad-group.id
}

*/