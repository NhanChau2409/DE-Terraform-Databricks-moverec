terraform {
  required_version = ">= 1.6.3"
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "=1.29.0"
    }
  }
}

provider "databricks" {
  # Authenticate through Azure CLI
  host = var.host
}
