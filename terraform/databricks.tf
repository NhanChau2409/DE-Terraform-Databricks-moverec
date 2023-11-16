resource "azurerm_databricks_workspace" "this" {
  name                        = "${var.project}-databricks-workspace"
  resource_group_name         = azurerm_resource_group.this.name
  location                    = azurerm_resource_group.this.location
  sku                         = var.databricks-sku
  managed_resource_group_name = "${var.project}-databricks-workspace-rg"
}

data "databricks_node_type" "smallest" {
  local_disk = true
  depends_on = [
    azurerm_databricks_workspace.this
  ]
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on        = [
    azurerm_databricks_workspace.this
  ]
}

resource "databricks_cluster" "this" {
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  idempotency_token       = "movrec"
  autotermination_minutes = 20

  autoscale {
    min_workers = 1
    max_workers = 10
  }
}

#resource "databricks_secret_scope" "terraform" {
#    name                     = "application"
#    initial_manage_principal = "users"
#}
#
#resource "databricks_secret" "service_principal_key" {
#    key          = "service_principal_key"
#    string_value = ""
#    scope        = databricks_secret_scope.terraform.name
#}
