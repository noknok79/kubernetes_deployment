# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "insights" {
  name                = "logs-${random_pet.aksrandom.id}"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  retention_in_days   = 30
}