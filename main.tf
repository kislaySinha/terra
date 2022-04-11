terraform {

   required_providers {



    azurerm = "~>2.0"



  }

}

provider "azurerm" {
  skip_provider_registration=true
   features {}
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = "eastus"
  resource_group_name = "ks1"
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B4ms"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}