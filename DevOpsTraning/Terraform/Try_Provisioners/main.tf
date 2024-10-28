provider "azurerm" {
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

resource "null_resource" "local-exec" {
    depends_on = [ azurerm_resource_group.mani-rg ]
  provisioner "local-exec" {
    command = "terraform destroy -auto-approve"
  }
}
