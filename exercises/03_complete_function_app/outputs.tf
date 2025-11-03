output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.azurerm_resource_group.name
}

output "function_app_name" {
  description = "Name of the Function App"
  value       = module.avm_res_web_site.name
}

output "function_app_id" {
  description = "Resource ID of the Function App"
  value       = module.avm_res_web_site.resource_id
  sensitive   = true
}

output "function_app_resource_uri" {
  description = "Resource URI of the Function App"
  value       = module.avm_res_web_site.resource_uri
}

output "function_app_principal_id" {
  description = "Principal ID of the Function App managed identity"
  value       = module.avm_res_web_site.system_assigned_mi_principal_id
  sensitive   = true
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account.name
}

output "storage_account_id" {
  description = "Resource ID of the storage account"
  value       = module.storage_account.resource_id
}

output "service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.example.name
}

output "service_plan_id" {
  description = "Resource ID of the App Service Plan"
  value       = azurerm_service_plan.example.id
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics Workspace"
  value       = module.log_analytics.resource_id
}
