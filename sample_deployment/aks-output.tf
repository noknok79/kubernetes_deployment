output "resource_group_location" {
  value = azurerm_resource_group.aks_rg.location
}

output "resource_group_id" {
  value = azurerm_resource_group.aks_rg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.aks_rg.name
}
/*
output "aks-version" {
  value = data.azurerm_kubernetes_versions.curent.curent
}

output "latest_version" {
  value = data.azurerm_kubernetes_versions.curent.latest_version
}


output "azure_ad_group" {
  value = data.azuread_group.aks_administrators.id
}
*/

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_kubernetes_cluster_version" {
  value = azurerm_kubernetes_cluster.aks_cluster.kubernetes_version
}