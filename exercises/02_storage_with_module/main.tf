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
  storage_use_azuread = true
}

resource "random_id" "suffix" {
  byte_length = 4
}

# Resource Group using Azure Verified Module (AVM)
module "azurerm_resource_group" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  version  = "0.2.1"
  name     = "${var.prefix}-workshop-rg"
  location = var.location
  tags     = var.tags
}

# Storage Account using Azure Verified Module (AVM)
module "avm_storage_account" {
  source                          = "Azure/avm-res-storage-storageaccount/azurerm"
  version                         = "~> 0.6.0"

  name                            = "${var.prefix}ws${random_id.suffix.hex}"
  resource_group_name             = module.azurerm_resource_group.name
  location                        = var.location

  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  
  # Security settings
  shared_access_key_enabled       = false
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  managed_identities = {
    system_assigned               = true
  }
  network_rules = {
    bypass                        = ["AzureServices"]
    default_action                = "Deny"
  }

  # Container for deployments
  containers = {
    blob_container1 = {
      name                        = "deployments"
      container_access_type       = "private"
    }
  }

  tags = var.tags
}