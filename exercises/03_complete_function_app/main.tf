terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  storage_use_azuread = true
  features {}
}

# Resource Group
module "azurerm_resource_group" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  version  = "0.2.1"
  name     = "${var.prefix}-workshop-rg"
  location = var.location
  tags     = var.tags
}

# Log Analytics Workspace
module "log_analytics" {
  source                                    = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version                                   = "~> 0.4.0"

  name                                      = "${var.prefix}-funcapp-law"
  resource_group_name                       = module.azurerm_resource_group.name
  location                                  = var.location

  log_analytics_workspace_retention_in_days = 30
  log_analytics_workspace_sku               = "PerGB2018"
  
  tags = var.tags
}

# Storage Account
module "storage_account" {
  source                                    = "Azure/avm-res-storage-storageaccount/azurerm"
  version                                   = "~> 0.6.0"

  name                                      = "${var.prefix}funcappsa"
  resource_group_name                       = module.azurerm_resource_group.name
  location                                  = var.location

  account_tier                              = "Standard"
  account_replication_type                  = "LRS"

  # Security settings
  shared_access_key_enabled                 = true
  public_network_access_enabled             = true
  allow_nested_items_to_be_public           = false
  https_traffic_only_enabled                = true
  min_tls_version                           = "TLS1_2"

  # Blob properties for versioning and soft delete
  blob_properties = {
    versioning_enabled                      = false
    change_feed_enabled                     = false
    last_access_time_enabled                = false
    container_delete_retention_policy_days  = 7
    delete_retention_policy_days            = 7
  }

  # Container for deployment packages
  containers = {
    deployments = {
      name                                  = "deployments"
      container_access_type                 = "private"
    }
  }

  tags                                      = var.tags
}


# Service Plan for Flex Consumption
resource "azurerm_service_plan" "example" {
  location            = var.location
  name                = "${var.prefix}-funcapp-sp"
  os_type             = "Linux"
  resource_group_name = module.azurerm_resource_group.name
  sku_name            = "FC1"
  tags                = var.tags
}

module "avm_res_web_site" {
  source                    = "Azure/avm-res-web-site/azurerm"
  version                   = "~> 0.19.1"

  kind                      = "functionapp"
  location                  = var.location
  name                      = "${var.prefix}-workshop-funcapp"
  # Uses an existing app service plan
  os_type                   = azurerm_service_plan.example.os_type
  resource_group_name       = module.azurerm_resource_group.name
  service_plan_resource_id  = azurerm_service_plan.example.id
  fc1_runtime_name          = "node"
  fc1_runtime_version       = "20"
  function_app_uses_fc1     = true
  instance_memory_in_mb     = 2048
  managed_identities = {
    # Identities can only be used with the Standard SKU
    system_assigned = true
    user_assigned_resource_ids = [
      azurerm_user_assigned_identity.user.id
    ]
  }
  maximum_instance_count = 100
  # Uses an existing storage account
  # storage_account_access_key = azurerm_storage_account.example.primary_access_key
  # storage_authentication_type = "StorageAccountConnectionString"
  storage_authentication_type       = "UserAssignedIdentity"
  storage_container_endpoint        = module.storage_account.containers["deployments"].id
  storage_container_type            = "blobContainer"
  storage_user_assigned_identity_id = azurerm_user_assigned_identity.user.id
  tags = var.tags
}

resource "azurerm_user_assigned_identity" "user" {
  location            = var.location
  name                = "${var.prefix}-funcapp-uai"
  resource_group_name = module.azurerm_resource_group.name
}