variable "region" {
  description = "The region for Azure services"
  type    = string
  default = "westeurope"
}

variable "prefix" {
  description = "The prefix naming for Azure services"
  type    = string
  default = "movrec"
}

variable "databricks-sku" {
  description = "The Databricks tier configs - standard/premium"
  type = string
  default = "standard"
}

variable "TENANT_ID" {
  description = "The Azure tenant id"
  type        = string
}

variable "SUBSCRIPTION_ID" {
  description = "The Azure subscription id"
  type        = string
}
