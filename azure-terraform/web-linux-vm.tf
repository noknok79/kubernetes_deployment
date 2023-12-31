/* 
#Can set locals to run desired commands on the VM
#It must call the web_custom_data below like custom_data = base64encode(local.webvm_custom_data)
locals {
  webvm_custom_data = <<CUSTOM_DATA
#!/bin/bash
apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && apt update -y && apt-get install docker-ce docker-ce-cli containerd.io -y && apt update -y
/lib/systemd/systemd-sysv-install enable docker
systemctl start docker
docker run -d -p 27017:27017 --name mongo -v /data/db:/data/db mongo:latest 
docker run -d -p 8080:8080 --link mongo:mongo noknok79/parts-order:latest 
docker run -it -d --name web -p 80:80 noknok79/parts-web:latest 

  CUSTOM_DATA
}

*/

resource "azurerm_linux_virtual_machine" "web-linuxvm" {
  name = "${local.resource_name_prefix}-web-linuxvm"
  #computer_name       = "${local.resource_name_prefix}-web-linuxvm"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  size                = "Standard_DS1_v2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_linuxvm_nic.id
  ]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    name                 = "${local.resource_name_prefix}-web-linuxvm-${random_string.myrandomstring.id}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  tags        = local.common_tags
  custom_data = filebase64("${path.module}/app-scripts/install-parts-docker.sh")
  #custom_data = base64encode(local.webvm_custom_data)
}