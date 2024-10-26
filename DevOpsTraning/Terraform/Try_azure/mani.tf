provider "azurerm" {
    // set the subscription id
    subscription_id = var.subscription_id
  features {}
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

resource "azurerm_resource_group" "mani-rg" {
  name     = "mani-rg"
  location = "East US"
}


resource "azurerm_storage_account" "mani-storage" {
  name                     = "manistorageaccount"
  resource_group_name      = azurerm_resource_group.mani-rg.name
  location                 = azurerm_resource_group.mani-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "test21"
  }
}

resource "azurerm_storage_container" "mani-container" {
  name                  = "manicontainer"
  storage_account_name  = azurerm_storage_account.mani-storage.name
  container_access_type = "private"
}
