# Azure Location
variable "location" {
  type        = string
  description = "Azure Region where all these resources will be provisioned"
  default     = "Central US"
}

# Azure Resource Group Name
variable "resource_group_name" {
  type        = string
  description = "This variable defines the Resource Group"
  default     = "terraform-aks"
}

# Azure AKS Environment Name
variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  default     = "dev"
}


variable "ssh_public_key" {
  type        = string
  default     = "~/.ssh/aks-prod/aksprodsshkey.pub"
  description = "Variables for ssh key"
}

variable "windows_admin_username" {
  type        = string
  default     = "azureuser"
  description = "Variables for windows admin username"
}

variable "windows_admin_password" {
  type        = string
  default     = "P@ssw0rd1234"
  description = "Variables for windows admin password"
}
