resource "azurerm_network_interface" "networkinterace" {
  name                = "${var.name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${var.name}-ipconfig"
    subnet_id                     = data.azurerm_subnet.subnetinfo.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
    private_ip_address_version    = "IPv4"
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "windowsvirtualmachine" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = data.azurerm_key_vault_secret.keyvaultsecretinfo.value
  network_interface_ids = [azurerm_network_interface.networkinterace.id]

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.gallery_resource_group}/providers/Microsoft.Compute/galleries/${var.gallery_name}/images/${var.image_definition}/versions/${var.image_version}"

  # source_image_reference {
  #   publisher = var.source_image_reference.publisher
  #   offer     = var.source_image_reference.offer
  #   sku       = var.source_image_reference.sku
  #   version   = var.source_image_reference.version
  # }

  tags = var.tags

  custom_data = base64encode(<<EOT
    Write-Output "Initializing Windows VM..." > C:\init_log.txt
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    EOT
  )
  # base64encode(templatefile("${path.module}/scripts/psscript.tpl", { ##base64encode(file("${path.module}/scripts/psscript.ps1"))
  #   message = "Test Message"
  # }))

  boot_diagnostics {
    storage_account_uri = null #azurerm_storage_account.storageaccount.primary_blob_endpoint
  }
  
  lifecycle {
    ignore_changes = [os_disk, admin_username, admin_password, tags, custom_data]
  }
}

resource "azurerm_managed_disk" "manageddisk" {
  for_each             = { for idx, disk in var.managed_disks : disk.name => disk } # Convert list to map
  name                 = each.value.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb
  tags                 = var.tags
  lifecycle {
    ignore_changes = [tags, encryption_settings]
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  for_each           = azurerm_managed_disk.manageddisk # Iterate over all managed disks
  managed_disk_id    = each.value.id
  virtual_machine_id = azurerm_windows_virtual_machine.windowsvirtualmachine.id
  lun                = index(keys(azurerm_managed_disk.manageddisk), each.key) + 10 #  Generate a unique LUN for each disk
  caching            = "ReadWrite"
}