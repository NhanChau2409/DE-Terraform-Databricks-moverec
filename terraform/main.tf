terraform {
  required_version = ">= 1.6.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.SUBSCRIPTION_ID
  tenant_id       = var.TENANT_ID
}

resource "azurerm_resource_group" "this" {
  location = var.region
  name     = "${var.prefix}-rg"
}

resource "azurerm_databricks_workspace" "this" {
  name                        = "${var.prefix}-databricks-workspace"
  resource_group_name         = azurerm_resource_group.this.name
  location                    = azurerm_resource_group.this.location
  sku                         = var.databricks-sku
  managed_resource_group_name = "${var.prefix}-databricks-workspace-rg"
}

module "databricks" {
  source = "./modules/databricks"
  host = azurerm_databricks_workspace.this.workspace_url
}


