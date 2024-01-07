# Provider configuration
provider "azurerm" {
    features {}
}

# Resource group
resource "azurerm_resource_group" "example" {
    name     = "example-resource-group"
    location = "West Europe"
}

# Virtual network
resource "azurerm_virtual_network" "example" {
    name                = "example-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
}

# Subnet
resource "azurerm_subnet" "example" {
    name                 = "example-subnet"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes     = ["10.0.1.0/24"]
}

# Network security group
resource "azurerm_network_security_group" "example" {
    name                = "example-nsg"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
}

# Public IP
resource "azurerm_public_ip" "example" {
    name                = "example-public-ip"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    allocation_method   = "Static"
}

# Network interface
resource "azurerm_network_interface" "example" {
    name                = "example-nic"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name

    ip_configuration {
        name                          = "example-ip-config"
        subnet_id                     = azurerm_subnet.example.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.example.id
    }
}

# Virtual machine
resource "azurerm_virtual_machine" "example" {
    name                  = "example-vm"
    location              = azurerm_resource_group.example.location
    resource_group_name   = azurerm_resource_group.example.name
    network_interface_ids = [azurerm_network_interface.example.id]
    vm_size               = "Standard_DS1_v2"

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name              = "example-os-disk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name  = "example-vm"
        admin_username = "adminuser"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
}

# Desired state configuration using Ansible
resource "null_resource" "ansible_provisioner" {
    depends_on = [azurerm_virtual_machine.example]

    provisioner "local-exec" {
        command = "ansible-playbook -i ${azurerm_public_ip.example.ip_address}, playbook.yml"
        working_dir = "/path/to/ansible/playbook"
    }
}
