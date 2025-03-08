variable "resource_group_info" {
  description = "Information about the resource group"
  type = list(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}

variable "virtual_network_info" {
  description = "Information about the virtual network"
  type = list(object({
    name                = string
    resource_group_name = string
    address_space       = list(string)
    tags                = map(string)
  }))
}

variable "subnet_info" {
  description = "Information about the subnet"
  type = list(object({
    name                 = string
    virtual_network_name = string
    address_space        = list(string)
  }))
}

# variable "windows_virtual_machine_info" {
#   description = "Information about the Windows virtual machine"
#   type = list(object({
#     name                 = string
#     resource_group_name  = string
#     virtual_network_name = string
#     subnet_name          = string
#     private_ip_address   = string
#     vm_size              = string
#     admin_username       = string
#     subscription_id        = string
#     gallery_resource_group = string
#     gallery_name           = string
#     image_definition       = string
#     image_version          = string

#     key_vault_info = object({
#       name                = string
#       secret_name         = string
#       resource_group_name = string
#     })
#     os_disk = object({
#       caching              = string
#       storage_account_type = string
#     })
#     # source_image_reference = object({
#     #   publisher = string
#     #   offer     = string
#     #   sku       = string
#     #   version   = string
#     # })
#     managed_disks = list(object({
#       name                 = string
#       storage_account_type = string
#       create_option        = string
#       disk_size_gb         = number
#     }))

#     tags = map(string)
#   }))
# }

variable "nsg_info" {
  description = "Information about the network security group"
  type = list(object({
    name                = string
    location            = string
    resource_group_name = string
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_ranges    = list(string)
      source_address_prefix      = string
      destination_address_prefix = string
    }))
    association = list(object({
      subnet_name          = string
      virtual_network_name = string
    }))
    tags = map(string)
  }))
}

# variable "sql_managed_instance_info" {
#   description = "Information about the SQL managed instance"
#   type = list(object({
#     sql_mi_name                      = string
#     resource_group_name              = string
#     location                         = string
#     sku_name                         = string
#     storage_account_type             = string
#     storage_size                     = number
#     vcores                           = number
#     vnet_name                        = string
#     subnet_name                      = string
#     key_vault_name                   = string
#     admin_username                   = string
#     key_vault_admin_pass_secret_name = string
#     license_type                     = string
#     collation                        = string
#     tags                             = map(string)
#   }))
# }