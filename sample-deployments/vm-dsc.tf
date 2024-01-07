resource "azurerm_resource_group" "example" {
    name     = "example-resource-group"
    location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
    name                = "example-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
    name                 = "example-subnet"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "example" {
    name                = "example-nic"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name

    ip_configuration {
        name                          = "example-ipconfig"
        subnet_id                     = azurerm_subnet.example.id
        private_ip_address_allocation = "Dynamic"
    }
}

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
        name              = "example-osdisk"
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

resource "azurerm_virtual_machine_extension" "example" {
    name                 = "example-dsc-extension"
    location             = azurerm_resource_group.example.location
    resource_group_name  = azurerm_resource_group.example.name
    virtual_machine_name = azurerm_virtual_machine.example.name
    publisher            = "Microsoft.Powershell"
    type                 = "DSC"
    type_handler_version = "2.81"

    settings = <<SETTINGS
        {
            "configuration": {
                "url": "https://example.com/dsc-config.ps1.zip",
                "script": "dsc-config.ps1",
                "function": "ConfigurationFunction"
            },
            "configurationArguments": {
                "Param1": "Value1",
                "Param2": "Value2"
            }
        }
    SETTINGS

    protected_settings = <<PROTECTED_SETTINGS
        {
            "configurationUrlSasToken": "https://example.com/dsc-config.ps1.zip?sastoken",
            "configurationFunction": "ConfigurationFunction"
        }
    PROTECTED_SETTINGS
}
