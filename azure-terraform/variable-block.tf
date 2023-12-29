variable "business_division" {
  #name = "business_division"
  description = "business division belongs to"
  type        = string
  default     = "sap"
}
variable "environment" {
  #name = "environment"
  description = "Environment Variables used in a prefix"
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  #name = "resource_group_name"
  description = "Resource Group Name"
  type        = string
  default     = "rg-default"
}

variable "resource_group_location" {
  #name = "resource_group_location"
  description = "Region in which Azure Resource is created"
  type        = string
  default     = "eastus"
}

variable "vnet-name" {
  #name = "vnet-name"
  description = "Virtual Network Name"
  type        = string
  default     = "vnet-default"

}

variable "vnet_address_space" {
  #name = "vnet_address_space"
  description = "Virtual Network Address Space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

#   Web Subnet and Address

variable "web_subnet_name" {
  #name = "web_subnet_name"
  description = "Virtual Network Web Subnet Name"
  type        = string
  default     = "web-subnet"
}

variable "web_subnet_address" {
  #name = "web_subnet_address"
  description = "Virtual Network Web Subnet Address Prefix"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

#   App Subnet and Address

variable "app_subnet_name" {
  #name = "app_subnet_name"
  description = "App Virtual Network Web Subnet Name"
  type        = string
  default     = "app-subnet"
}

variable "app_subnet_address" {
  #name = "app_subnet_address"
  description = "App Virtual Network Web Subnet Address Prefix"
  type        = list(string)
  default     = ["10.0.11.0/24"]
}

#   DB Subnet and Address

variable "db_subnet_name" {
  #name = "db_subnet_name"
  description = "DB Virtual Network Web Subnet Name"
  type        = string
  default     = "db-subnet"
}

variable "db_subnet_address" {
  # Remove the "name" attribute
  description = "DB Virtual Network Web Subnet Address Prefix"
  type        = list(string)
  default     = ["10.0.21.0/24"]
}

#   Bastion Subnet and Address

variable "bastion_subnet_name" {
  #name = "bastion_subnet_name"
  description = "Bastion Virtual Network Web Subnet Name"
  type        = string
  default     = "bastion-subnet"
}

variable "bastion_subnet_address" {
  #name = "bastion_subnet_address"
  description = "Bastion Virtual Network Web Subnet Address Prefix"
  type        = list(string)
  default     = ["10.0.100.0/24"]
}