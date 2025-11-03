output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account.name
}

output "storage_account_id" {
  description = "Resource ID of the storage account"
  value       = module.storage_account.id
}
