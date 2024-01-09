# Create a resource group

resource "random_string" "myrandom" {
  length  = 16
  special = false
  upper   = false
}

resource "azurerm_storage_account" "mystorage" {
  name                     = "mysa${random_string.myrandom.id}"
  resource_group_name      = azurerm_resource_group.myrg.name
  location                 = azurerm_resource_group.myrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Remove the unexpected attribute
  #account_storage_source = "Microsoft.Storage/storageAccounts"
  tags = {
    environment = "stagging"
  }
}

resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  tags = {
    "Name" = "myvnet-1"
  }
}

resource "azurerm_subnet" "mysubnet" {
  name                 = "mysubnet"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "mypublicip" {
  name                = "mypublicip-1"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "myvmnic" {
  name                = "mynic-1"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internet"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublicip.id
  }
}

