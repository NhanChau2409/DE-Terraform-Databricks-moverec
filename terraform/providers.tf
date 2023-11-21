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
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.46.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }

  }

}

provider "azurerm" {
  features {}
}

provider "databricks" {
  # Authenticate through Azure CLI
  host                        = azurerm_databricks_workspace.this.workspace_url
  azure_workspace_resource_id = azurerm_databricks_workspace.this.id
}

provider "random" {}