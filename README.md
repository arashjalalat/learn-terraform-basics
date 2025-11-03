# Terraform Azure Functions Workshop

This repository contains hands-on exercises for learning Terraform with Azure Functions Flex Consumption.

## Prerequisites

- Azure subscription
- Terraform installed
- Azure CLI installed and authenticated (`az login`)
- Code editor (VS Code recommended with Terraform extension)

## Getting Started

1. Clone this repository from Azure DevOps
2. Navigate to the exercise folder you want to work on
3. Copy `terraform.tfvars.example` to `terraform.tfvars`
4. Update variables with your unique values
5. Run Terraform commands

## Exercise Overview

### Exercise 1: Simple Storage Account
Location: [`exercises/01_storage_account`](/exercises/01_storage_account/)

### Exercise 2: Using Azure Verified Modules
Location: [`exercises/02_storage_with_module`](/exercises/02_storage_with_module/)

### Exercise 3: Complete Function App Solution
Location: [`exercises/03_complete_function_app`](/exercises/03_complete_function_app/)

## Terraform Commands Reference

#### Initialize (download providers)
`terraform init`

#### Validate syntax
`terraform validate`

#### Format code
`terraform fmt`

#### Preview changes
`terraform plan`

#### Apply changes
`terraform apply`

#### Destroy resources
`terraform destroy`