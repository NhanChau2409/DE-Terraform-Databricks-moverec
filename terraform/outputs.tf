output "databricks_host" {
  value = azurerm_databricks_workspace.this.workspace_url
}

output "rg_name" {
  value = azurerm_resource_group.this.name
}

output "rg_location" {
  value = azurerm_resource_group.this.location
}