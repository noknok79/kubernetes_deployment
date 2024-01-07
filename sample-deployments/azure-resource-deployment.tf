# Provider configuration
provider "azurerm" {
    features {}
}

# Resource group
resource "azurerm_resource_group" "aks_rg" {
    name     = "my-resource-group"
    location = "West US"
}

# Virtual network
resource "azurerm_virtual_network" "aks_vnet" {
    name                = "my-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.aks_rg.location
    resource_group_name = azurerm_resource_group.aks_rg.name
}

# Subnet
resource "azurerm_subnet" "aks_subnet" {
    name                 = "my-subnet"
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

# Cosmos DB account
resource "azurerm_cosmosdb_account" "cosmosdb" {
    name                = "my-cosmosdb-account"
    location            = azurerm_resource_group.aks_rg.location
    resource_group_name = azurerm_resource_group.aks_rg.name
    offer_type          = "Standard"
    kind                = "MongoDB"

    consistency_policy {
        consistency_level       = "Session"
        max_interval_in_seconds = 5
        max_staleness_prefix    = 100
    }
}

# SQL Server
resource "azurerm_mssql_server" "sql_server" {
    name                = "my-sql-server"
    location            = azurerm_resource_group.aks_rg.location
    resource_group_name = azurerm_resource_group.aks_rg.name
    version             = "12.0"
    administrator_login = "admin"
    administrator_login_password = "P@ssw0rd123!"
}

# SQL Database
resource "azurerm_mssql_database" "sql_db" {
    name                = "my-sql-db"
    location            = azurerm_resource_group.aks_rg.location
    resource_group_name = azurerm_resource_group.aks_rg.name
    server_name         = azurerm_mssql_server.sql_server.name
    edition             = "Standard"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    max_size_gb         = 10



    # Custom tables
    custom_tables = [
        {
            name = "table1"
            columns = [
                {
                    name = "column1"
                    type = "varchar(255)"
                },
                {
                    name = "column2"
                    type = "int"
                }
            ]
        },
        {
            name = "table2"
            columns = [
                {
                    name = "column1"
                    type = "varchar(50)"
                },
                {
                    name = "column2"
                    type = "datetime"
                }
            ]
        }
    ]
}

# SQL Firewall Rule
resource "azurerm_mssql_firewall_rule" "sql_firewall_rule" {
    name                = "my-sql-firewall-rule"
    resource_group_name = azurerm_resource_group.aks_rg.name
    server_name         = azurerm_mssql_server.sql_server.name
    start_ip_address    = "0.0.0.0"
    end_ip_address      = "255.255.255.255"
}


