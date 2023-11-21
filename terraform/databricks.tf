resource "azurerm_databricks_workspace" "this" {
  name                        = "${var.project}-databricks-workspace"
  resource_group_name         = azurerm_resource_group.this.name
  location                    = azurerm_resource_group.this.location
  sku                         = var.databricks-sku
  managed_resource_group_name = "${var.project}-databricks-workspace-rg"
}

resource "databricks_service_principal" "sp" {
  application_id = azuread_application.this.application_id
  display_name   = azuread_application.this.display_name
}

resource "databricks_secret_scope" "terraform" {
  name                     = "application"
  initial_manage_principal = "users"
}

resource "databricks_secret" "service_principal_key" {
  key          = "service_principal_key"
  string_value = azuread_service_principal_password.this.value
  scope        = databricks_secret_scope.terraform.name
}

resource "azurerm_role_assignment" "this" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.this.id
}

resource "databricks_mount" "this" {
  abfs {
    client_id              = azuread_service_principal.this.application_id
    client_secret_key      = databricks_secret.service_principal_key.key
    client_secret_scope    = databricks_secret_scope.terraform.name
    container_name         = azurerm_storage_container.this.name
    storage_account_name   = azurerm_storage_account.this.name
    initialize_file_system = true
  }
}
