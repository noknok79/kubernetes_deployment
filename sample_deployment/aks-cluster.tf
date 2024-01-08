resource "azurerm_kubernetes_cluster" "aks_cluster" {
    dns_prefix = "${azurerm_resource_group.aks_rg.name}-cluster"
    location            = azurerm_resource_group.aks_rg.location
    name                = "${azurerm_resource_group.aks_rg.name}-cluster"
    resource_group_name = azurerm_resource_group.aks_rg.name
    kubernetes_versions = data.azurerm_kubernetes_service_versions.current.latest_version
    node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"

    default_node_pool {
        name       = "systempool"
        vm_size    = "Standard_DS2_v2"
        orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
        availability_zones = [1, 2, 3]
        enable_auto_scaling = true
        max_count           = 3
        min_count           = 1
        os_disk_size_gb     = 30
        type                = "VirtualMachineScaleSets"
        node_count = 3
        node_labels = {
            "nodepool-type" = "system" 
            "environment" = "dev"
            "nodepool" = "linux"
            "app"   = "system-app"
        }
    }
    
    identity {type = "SystemAssigned"}

    addon_profile {
        azure_policy {enabled = true}
        oms_agent { 
            enabled = true 
            azurerm_log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
        }
    }
    
    role_based_access_control {
        enabled = true
        azure_active_directory {
            managed = true
            admin_group_object_ids = [data.azurerm_group.aks_administrators.id]
        }
    }

    windows_profile {
        admin_username = var.windows.admin_username
        admin_password = var.windows.admin_password
    }

    linux_profile {
        admin_username = var.linux.admin_username
        ssh_key {
            key_data = file(var.linux.ssh_key)
        }
    }
    
    tags = {
        Environment = "Prod"
    }
    
}
