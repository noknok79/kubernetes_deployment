resource "azurerm_kubernetes_cluster_node_pool" "linux101" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  zones                 = [1, 2, 3]
  mode                  = "User"
  enable_auto_scaling   = true
  max_count             = 3
  min_count             = 1
  name                  = "linux101"
  orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  os_disk_size_gb       = 30
  os_type               = "Linux"
  vm_size               = "Standard_DS2_v2"
  priority              = "Regular"
  node_labels = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "app"           = "java-apps"
  }
  tags = {
    "nodepool-type" = "user"
    "environment"   = var.environment
    "nodepoolos"    = "linux"
    "app"           = "java-apps"
  }
}
