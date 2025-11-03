terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "workshop" {
  name     = "${var.prefix}-workshop-rg"
  location = var.location

  tags = var.tags
}

# Short unique suffix for globally-unique names (hex, lowercase)
resource "random_id" "suffix" {
  byte_length = 4
}

# Storage Account
resource "azurerm_storage_account" "workshop" {
  name                            = "${var.prefix}ws${random_id.suffix.hex}"
  resource_group_name             = azurerm_resource_group.workshop.name
  location                        = azurerm_resource_group.workshop.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  
  # Security best practices
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  tags = var.tags
 }

# Storage Container for deployment packages
resource "azurerm_storage_container" "deployments" {
  name                  = "deployments"
  storage_account_id    = azurerm_storage_account.workshop.id
  container_access_type = "private"
}
