variable "name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "location" {
  description = "Location of the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "private_ip_address" {
  description = "Private IP address of the virtual machine"
  type        = string
}

variable "size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username of the virtual machine"
  type        = string
}

variable "key_vault_info" {
  description = "Information about the key vault"
  type = object({
    name                = string
    secret_name         = string
    resource_group_name = string
  })
}

variable "os_disk" {
  description = "OS disk of the virtual machine"
  #type = map(string)
  type = object({
    caching              = string
    storage_account_type = string
  })
}

# variable "source_image_reference" {
#   description = "Source image reference of the virtual machine"
#   #type = map(string)
#   type = object({
#     publisher = string
#     offer     = string
#     sku       = string
#     version   = string
#   })
# }

variable "managed_disks" {
  type = list(object({
    name                 = string
    storage_account_type = string
    create_option        = string
    disk_size_gb         = number
  }))
}

variable "tags" {
  description = "Tags for the virtual machine"
  type        = map(string)
}


###################################


variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "gallery_resource_group" {
  description = "Resource Group where the Azure Compute Gallery is located"
  type        = string
}

variable "gallery_name" {
  description = "Name of the Azure Compute Gallery"
  type        = string
}

variable "image_definition" {
  description = "Name of the Image Definition in the Compute Gallery"
  type        = string
}

variable "image_version" {
  description = "Version of the Image to use"
  type        = string
}
