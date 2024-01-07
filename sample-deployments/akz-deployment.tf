# Provider configuration
provider "azurerm" {
    features {}
}

# Resource group
resource "azurerm_resource_group" "aks_rg" {
    name     = "my-aks-rg"
    location = "eastus"
}

# Virtual network
resource "azurerm_virtual_network" "aks_vnet" {
    name                = "my-aks-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.aks_rg.location
    resource_group_name = azurerm_resource_group.aks_rg.name
}

# Subnet
resource "azurerm_subnet" "aks_subnet" {
    name                 = "aks-subnet"
    resource_group_name  = azurerm_resource_group.aks_rg.name
    virtual_network_name = azurerm_virtual_network.aks_vnet.name
    address_prefixes     = ["10.0.1.0/24"]
}

# AKS cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
    name                = "my-aks-cluster"
    location            = azurerm_resource_group.aks_rg.location
    resource_group_name = azurerm_resource_group.aks_rg.name
    dns_prefix          = "myakscluster"
    kubernetes_version  = "1.21.2"

    default_node_pool {
        name                = "default"
        node_count          = 3
        vm_size             = "Standard_DS2_v2"
        vnet_subnet_id      = azurerm_subnet.aks_subnet.id
        enable_auto_scaling = true
        min_count           = 3
        max_count           = 5
    }
}
