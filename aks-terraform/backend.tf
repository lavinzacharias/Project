terraform {
  backend "azurerm" {
    resource_group_name = "Terra-starage"
    storage_account_name= "lavinstarage3056"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}
