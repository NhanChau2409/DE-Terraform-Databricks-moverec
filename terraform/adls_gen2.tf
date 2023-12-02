resource "azurerm_storage_account" "this" {
  name                     = "${var.project}strgacc"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = var.storage-account-tier
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_container" "this" {
  name                 = "${var.project}-container"
  storage_account_name = azurerm_storage_account.this.name
}

