resource "azuread_group" "aks_administrators" {
  name = "${azurerm_resource_group.aks_rg.name}-cluster-administrators"
  description = "Example AD Group "${azurerm_resource_group.aks_rg.name}"

}