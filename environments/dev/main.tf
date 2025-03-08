module "resource_group" {
  source   = "../../modules/resourcegroup"
  for_each = { for resourcegroup in var.resource_group_info : resourcegroup.name => resourcegroup }

  name     = each.value.name
  location = each.value.location
  tags     = each.value.tags
}

module "virtual_network" {
  source   = "../../modules/virtualnetwork"
  for_each = { for virtualnetwork in var.virtual_network_info : virtualnetwork.name => virtualnetwork }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = module.resource_group[each.value.resource_group_name].resourcegroupinfo.location
  address_space       = each.value.address_space
  tags                = each.value.tags

  depends_on = [module.resource_group]
}

module "subnet" {
  source   = "../../modules/subnet"
  for_each = { for subnet in var.subnet_info : subnet.name => subnet }

  name                 = each.value.name
  resource_group_name  = module.virtual_network[each.value.virtual_network_name].virtualnetworkinfo.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_space

  depends_on = [module.virtual_network]
}


# module "windows_virtual_machine" {
#   source   = "../../modules/windowsvm"
#   for_each = { for windowsvirtualmachine in var.windows_virtual_machine_info : windowsvirtualmachine.name => windowsvirtualmachine }

#   name                   = each.value.name
#   location               = module.resource_group[each.value.resource_group_name].resourcegroupinfo.location
#   resource_group_name    = each.value.resource_group_name
#   virtual_network_name   = each.value.virtual_network_name
#   subnet_name            = each.value.subnet_name
#   private_ip_address     = each.value.private_ip_address
#   size                   = each.value.vm_size
#   admin_username         = each.value.admin_username
#   subscription_id        = each.value.subscription_id
#   gallery_resource_group = each.value.gallery_resource_group
#   gallery_name           = each.value.gallery_name
#   image_definition       = each.value.image_definition
#   image_version          = each.value.image_version

#   key_vault_info = {
#     name                = each.value.key_vault_info.name
#     secret_name         = each.value.key_vault_info.secret_name
#     resource_group_name = each.value.key_vault_info.resource_group_name
#   }

#   os_disk = {
#     caching              = each.value.os_disk.caching
#     storage_account_type = each.value.os_disk.storage_account_type
#   }

#   # source_image_reference = {
#   #   publisher = each.value.source_image_reference.publisher   ####
#   #   offer     = each.value.source_image_reference.offer       ####
#   #   sku       = each.value.source_image_reference.sku         ####
#   #   version   = each.value.source_image_reference.version     ####
#   # }

#   managed_disks = each.value.managed_disks

#   tags       = each.value.tags
#   depends_on = [module.subnet]
# }



module "network_security_group" {
  source              = "../../modules/nsg"
  for_each            = { for nsg in var.nsg_info : nsg.name => nsg }
  name                = each.value.name
  location            = module.resource_group[each.value.resource_group_name].resourcegroupinfo.location
  resource_group_name = each.value.resource_group_name
  security_rules      = each.value.security_rules
  tags                = each.value.tags
  association         = each.value.association
  depends_on          = [module.subnet]
}

# module "sql_managed_instance" {
#   source                           = "../../modules/sqlmanagedinstance"
#   for_each                         = { for sqlmanagedinstance in var.sql_managed_instance_info : sqlmanagedinstance.name => sqlmanagedinstance }
#   sql_mi_name                      = each.value.sql_mi_name
#   resource_group_name              = each.value.resource_group_name
#   location                         = each.value.location
#   sku_name                         = each.value.sku_name
#   storage_account_type             = each.value.storage_account_type
#   storage_size                     = each.value.storage_size
#   vcores                           = each.value.vcores
#   vnet_name                        = each.value.vnet_name
#   subnet_name                      = each.value.subnet_name
#   key_vault_name                   = each.value.key_vault_name
#   admin_username                   = each.value.admin_username
#   key_vault_admin_pass_secret_name = each.value.key_vault_admin_pass_secret_name
#   license_type                     = each.value.license_type
#   collation                        = each.value.collation
#   tags                             = each.value.tags
# }