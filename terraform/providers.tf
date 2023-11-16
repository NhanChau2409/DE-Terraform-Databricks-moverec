terraform {
  required_version = ">= 1.6.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "=1.29.0"
    }

  }
}

provider "azurerm" {
  features {}
  #  subscription_id = var.SUBSCRIPTION_ID
  #  tenant_id       = var.TENANT_ID
}

provider "databricks" {
  # Authenticate through Azure CLI
  host = azurerm_databricks_workspace.this.workspace_url
}
