terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# Declare the RG first

resource "azurerm_resource_group" "example-resources" {
  name     = "example-resources"
  location = "centralindia"
}

# Declare the Virtual network

resource "azurerm_virtual_network" "example-vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example-resources.location
  resource_group_name = azurerm_resource_group.example-resources.name
}

# Declare the Subnet

resource "azurerm_subnet" "internal" {
  name                 = "internal-subnet"
  resource_group_name  = azurerm_resource_group.example-resources.name
  virtual_network_name = azurerm_virtual_network.example-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Declare the Kubernetes Cluster

resource "azurerm_kubernetes_cluster" "example-aks-cluster" {
  name                = "example-aks-cluster"
  location            = azurerm_resource_group.example-resources.location
  resource_group_name = azurerm_resource_group.example-resources.name
  dns_prefix          = "exampleaks"

  default_node_pool {
    name       = "kubepool"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}



