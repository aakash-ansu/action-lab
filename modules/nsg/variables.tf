variable "name" {
  description = "The name of the network security group."
  type        = string
}

variable "location" {
  description = "The location/region where the network security group will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the network security group will be created."
  type        = string
}

variable "security_rules" {
  description = "The security rules associated with the network security group."
  type = list(object({
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
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "association" {
  type = list(object({
    subnet_name          = string
    virtual_network_name = string
  }))
}