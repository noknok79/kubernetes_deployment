data "azurerm_kubernetes_versions" "curent" {
  #location = "centralus"
  location = azurerm_resource_group.aks_rg.location
  include_preview_versions = false
}
