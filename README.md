## Purpose 

This repository will provide a method to create multiple Google Groups to force a conflicting account for former employees who created personal Google Identities with their corporate email address. The benefit of creating a Google group rather than a Google user identity is the following:  

1. Creating an identity for former employee will create policy issues for most organizations.
1. Avoids using a license (Cloud Identity or Workspace) for a former employee.

If you have no idea what a conflict account is the best guide is found [here](https://www.goldyarora.com/google-conflicting-accounts-guide/).

## Prerequisites

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.13.x
- [terraform-provider-google](https://github.com/terraform-providers terraform-provider-google) plugin 3.50

## Update Backend & Terraform variables

1. Change to deployment directory
   ```
   cd envs/development
   ```
1. Update `backend.tf` with an existing GCS bucket to store Terraform state.
   ```
   bucket = "UPDATE_ME"
   ```
1. Rename `terraform.example.tfvars` to `terraform.tfvars` and update the file with values from your environment:
   ```
   mv terraform.example.tfvars terraform.tfvars
   ```

## Deploy Cloud Groups

### Deploy via a desktop

1. Run `terraform init`
1. Run `terraform plan` and review the output.
1. Run `terraform apply`

## Required Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | Domain of the organization to create the group in | `string` | n/a | yes |
| project\_id | The ID of the project in which to provision resources and used for billing | `string` | n/a | yes |
| groups | name of all groups with the former employee prefix | `string` | n/a | yes |


