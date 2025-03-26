terraform {
  backend "azurerm" {
    resource_group_name = "deploy-first-containerapp-rg"
    storage_account_name= "terraformstate3053"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}
