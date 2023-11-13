plugin "terraform" {
    enabled = true
    version = "0.2.0"
    source  = "github.com/terraform-linters/tflint-ruleset-terraform"
    preset  = "recommended"
}


plugin "azurerm" {
    enabled = true
    version = "0.25.1"
    source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

