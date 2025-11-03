# Tasks

1. Copy `terraform.tfvars.example` to `terraform.tfvars` (or use the same as exercise 1):
    - update with unique prefix, e.g. your name
    - update Owner with your name

1. In the `main.tf` and `module "avm_storage_account"` add a role assignment
    - tip: follow this [url](https://registry.terraform.io/modules/Azure/avm-res-storage-storageaccount/azurerm/latest)
    - go to Examples -> role_assignments
    - add yourself as `Storage Blob Data Contributor`. Use your own principal ID

1. Run `terraform init` to initialize the working directory (check if you are in the correct working directory!)

1. Run `terraform validate` to check syntax
    - fix the errors

1. Run `az login` and select the correct subscription

1. Run `export ARM_SUBSCRIPTION_ID=<subscription_id>`
    - Follow [this link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide#specifying-subscription-id-is-now-mandatory) for more info

1. Run `terraform plan -out tf.plan` to preview changes

1. Run `terraform apply tf.plan` to create resources

1. Verify storage account in Azure Portal
    - Go to IAM and check if you are assigned a role as `Storage Blob Data Contributor`

1. Run `terraform destroy` when done (optional)