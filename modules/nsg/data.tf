data "azurerm_subnet" "subnetinfo" {
  for_each             = { for subnet in var.association : subnet.subnet_name => subnet }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = var.resource_group_name
}