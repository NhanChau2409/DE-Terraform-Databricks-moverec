variable "location" {
  description = "(Optional) The region for Azure services"
  type        = string
  default     = "westeurope"
}

variable "project" {
  description = "(Optional) The prefix naming for Azure services"
  type        = string
  default     = "movrec"
}

variable "databricks-sku" {
  type        = string
  description = <<EOT
    (Optional) The SKU to use for the databricks instance"

    Default: standard
EOT
  default     = "standard" # Case sensitive
}

variable "storage-account-tier" {
  description = <<EOT
    (Optional) The tier of storage account"

    Default: Standard
EOT
  type        = string
  default     = "Standard" # Case sensitive
}

#variable "TENANT_ID" {
#  description = "The Azure tenant id"
#  type        = string
#}
#
#variable "SUBSCRIPTION_ID" {
#  description = "The Azure subscription id"
#  type        = string
#}