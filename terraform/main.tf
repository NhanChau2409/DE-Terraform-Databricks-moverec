data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  location = var.location
  name     = "${var.project}-rg"
}

resource "azuread_application" "this" {
  display_name = "databricks"
}

resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
}

resource "time_rotating" "month" {
  rotation_days = 30
}

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.object_id
  rotate_when_changed  = { rotation = time_rotating.month.id }
}