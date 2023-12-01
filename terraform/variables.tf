variable "location" {
  description = <<EOT
    (Optional) The region for Azure services

    Default: westeurope
EOT
  type        = string
  default     = "westeurope"
}

variable "project" {
  description = <<EOT
    (Optional) The prefix naming for Azure services

    Default: movrec
EOT
  type        = string
  default     = "movrec"
}

variable "databricks-sku" {
  type        = string
  description = <<EOT
    (Optional) The SKU to use for the databricks instance

    Default: standard
EOT
  default     = "standard" # Case sensitive
}

variable "storage-account-tier" {
  description = <<EOT
    (Optional) The tier of storage account

    Default: Standard
EOT
  type        = string
  default     = "Standard" # Case sensitive
}

variable "apikey" {
  description = <<EOT
    (Require) The TMDB api key
EOT
  type        = string
}