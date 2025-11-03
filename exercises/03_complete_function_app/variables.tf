variable "prefix" {
  description = "Prefix for resource names (max 8 characters, lowercase alphanumeric)"
  type        = string
  validation {
    condition     = length(var.prefix) <= 8 && can(regex("^[a-z0-9]+$", var.prefix))
    error_message = "Prefix must be lowercase alphanumeric and max 8 characters."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Workshop"
    ManagedBy   = "Terraform"
  }
}
