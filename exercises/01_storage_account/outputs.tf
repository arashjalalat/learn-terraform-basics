output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.workshop.name
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.workshop.name
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = azurerm_storage_account.workshop.primary_blob_endpoint
}
