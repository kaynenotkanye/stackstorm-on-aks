provider "azurerm" {
  features {}
}

# Learn our public IP address
data "http" "icanhazip" {
   url = "https://checkip.amazonaws.com"
}

resource "random_id" "randomId" {
    byte_length = 8
}

resource "azurerm_resource_group" "aksrg" {
  name = "kayne-aks-rg"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "kayne-st2-aks"
  location            = azurerm_resource_group.aksrg.location
  resource_group_name = azurerm_resource_group.aksrg.name
  identity {
    type = "SystemAssigned"
  }
  api_server_authorized_ip_ranges = ["${chomp(data.http.icanhazip.body)}/32"]
  dns_prefix          = "st2dns${random_id.randomId.hex}"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_B4ms"
    os_disk_size_gb = 32
  }

  tags = {
    saveSB = "true"
  }
}

output "authorized_ips_for_kubernetes" {
  value = "${chomp(data.http.icanhazip.body)}"
}
