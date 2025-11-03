# Tasks

1. Copy `terraform.tfvars.example` to `terraform.tfvars`:
    - update with unique prefix, e.g. your name
    - update Owner with your name

1. Run `terraform init` to initialize the working directory

1. Run `terraform validate` to check syntax

1. Run `az login` and select the correct subscription

1. Run `export ARM_SUBSCRIPTION_ID=<subscription_id>`
    - Follow [this link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide#specifying-subscription-id-is-now-mandatory) for more info

1. Run `terraform plan -out tf.plan` to preview changes

1. Run `terraform apply tf.plan` to create resources

1. Run again `terraform plan -out tf.plan` to preview changes
    - What will be updated?
    - How does Terraform compare the differences?

1. Run again `terraform apply tf.plan` to create resources. Note that nothing is changed!

1. Verify storage account in Azure Portal

1. Run `terraform destroy` when done (optional)