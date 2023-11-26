resource "azurerm_databricks_workspace" "this" {
  name                        = "${var.project}-databricks-workspace"
  resource_group_name         = azurerm_resource_group.this.name
  location                    = azurerm_resource_group.this.location
  sku                         = var.databricks-sku
  managed_resource_group_name = "${var.project}-databricks-workspace-rg"
}

# Create service principal for databricks workspace
resource "databricks_service_principal" "sp" {
  application_id = azuread_application.this.application_id
  display_name   = azuread_application.this.display_name
}

# Add CLIENT-SECRET into databricks secrets
resource "databricks_secret_scope" "terraform" {
  name                     = "application"
  initial_manage_principal = "users"
}

resource "databricks_secret" "service_principal_key" {
  key          = "service_principal_key"
  string_value = azuread_service_principal_password.this.value
  scope        = databricks_secret_scope.terraform.name
}

# Assign role for databricks on datalake gen 2
resource "azurerm_role_assignment" "this" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.this.id
}

# Create mount point to datalake gen 2
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

resource "databricks_cluster" "this" {
  spark_version           = "13.3.x-scala2.12"
  runtime_engine          = "PHOTON"
  driver_node_type_id     = "Standard_DS3_v2"
  node_type_id            = "Standard_DS3_v2"
  autotermination_minutes = 20
  enable_elastic_disk     = true
  spark_env_vars          = {
    "PYSPARK_PYTHON" = "/databricks/python3/bin/python3"
  }
  autoscale {
    max_workers = 4
    min_workers = 2
  }
}
