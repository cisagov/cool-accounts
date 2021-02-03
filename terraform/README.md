# cool-accounts - terraform subdirectory #

This subdirectory contains Terraform code to provision the COOL
"terraform" account.  It creates:

* The S3 bucket used to store Terraform state.
* The DynamoDB table used for Terraform state locking.
* An IAM role that allows sufficient access to the Terraform S3 bucket
  and DynamoDB table to use those resources as a Terraform backend.
  This role also has a trust relationship with the users account.
* An IAM role that allows sufficient permissions to provision all AWS
  resources in this account.  This role has a trust relationship with
  the users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because
initially there are no resources in this account that can be used to
host remote shared Terrafrom state, and also because there is no IAM
role that can be assumed to build out these resources.  Therefore you
must first apply this Terraform code with:

* No backend configuration, so that the state is created locally.
* Using programmatic credentials for AWSAdministratorAccess as
  obtained for the COOL terraform and users accounts from the AWS SSO
  page.

To do this, follow these steps:

1. Comment out all the content in the `backend.tf` file.
1. Comment out the `profile = "cool-terraform-provisionaccount"` line
   for the "default" provider in `providers.tf` and directly below
   that uncomment the line `profile = "cool-terraform-account-admin"`.
1. Comment out the `profile = "cool-users-provisionaccount"` line for
   the "default" provider in `providers.tf` and directly below that
   uncomment the line `profile = "cool-users-account-admin"`.
1. Create a new AWS profile called `cool-terraform-account-admin` in
   your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL terraform account:

   ```console
   [cool-terraform-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Create a new AWS profile called `cool-users-account-admin` in your
   Boto3 configuration using the "AWSAdministratorAccess" credentials
   (access key ID, secret access key, and session token) as obtained
   from the COOL users account:

   ```console
   [cool-users-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
   variables (see [Inputs](#Inputs) below for details):

   ```hcl
   state_bucket_name = "my-terraform-state-bucket"
   users_account_id = "222222222222"
   ```

1. Run the command `terraform init`.
1. Run the command `terraform apply
   -var-file=<workspace_name>.tfvars`.
1. Revert the changes you made to `backend.tf` in step 1.
1. Revert the changes you made to `provider.tf` in step 2.
1. Run the command `terraform init`.
1. Run the command `terraform apply
    -var-file=<workspace_name>.tfvars`.

At this point the account has been bootstrapped, and you can apply
future changes by simply running `terraform apply
-var-file=<workspace_name>.tfvars`.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 3.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access_domainmanager_terraform_backend_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `Allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend.` | no |
| access_domainmanager_terraform_backend_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `AccessDomainManagerTerraformBackend` | no |
| access_pca_terraform_backend_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `Allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend.` | no |
| access_pca_terraform_backend_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `AccessPCATerraformBackend` | no |
| access_terraform_backend_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `Allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend.` | no |
| access_terraform_backend_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `AccessTerraformBackend` | no |
| aws_region | The AWS region where the non-global resources for this account are to be provisioned (e.g. "us-east-1"). | `string` | `us-east-1` | no |
| domainmanager_terraform_projects | The list of project names that contain Domain Manager-related Terraform code (e.g. ["my-domain-manager-project"]). | `list(string)` | `[]` | no |
| pca_terraform_projects | The list of project names that contain PCA-related Terraform code (e.g. ["my-pca-project"]). | `list(string)` | `[]` | no |
| provisionaccount_role_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account. | `string` | `Allows sufficient permissions to provision all AWS resources in the Terraform account.` | no |
| provisionaccount_role_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account. | `string` | `ProvisionAccount` | no |
| provisionbackend_policy_description | The description to associate with the IAM policy that allows sufficient permissions to provision the Terraform backend resources in the Terraform account. | `string` | `Allows sufficient permissions to provision the Terraform backend resources in the Terraform account.` | no |
| provisionbackend_policy_name | The name to assign the IAM policy that allows sufficient permissions to provision the Terraform backend resources in the Terraform account. | `string` | `ProvisionBackend` | no |
| read_terraform_state_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored. | `string` | `Allows read-only access to the S3 bucket where Terraform state is stored.` | no |
| read_terraform_state_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored. | `string` | `ReadTerraformState` | no |
| state_bucket_name | The name to use for the S3 bucket that will store the Terraform state. | `string` | n/a | yes |
| state_table_name | The name to use for the DynamoDB table that will be used for Terraform state locking. | `string` | `terraform-state-lock` | no |
| state_table_read_capacity | The number of read units for the DynamoDB table that will be used for Terraform state locking. | `number` | `20` | no |
| state_table_write_capacity | The number of write units for the DynamoDB table that will be used for Terraform state locking. | `number` | `20` | no |
| tags | Tags to apply to all AWS resources provisioned. | `map(string)` | `{}` | no |
| users_account_id | The ID of the users account.  This account will be allowed to assume the role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend, as well as the role that allows sufficient permissions to provision all AWS resources in the Terraform account. | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| access_pca_terraform_backend_role | The IAM role that allows sufficient access to the the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. |
| access_terraform_backend_role | The IAM role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. |
| provisionaccount_role | The IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account. |
| read_terraform_state_role | The IAM role that allows read-only access to the S3 bucket where Terraform state is stored. |
| state_bucket | The S3 bucket where Terraform state information will be stored. |
| state_lock_table | The DynamoDB table that to be used for Terraform state locking. |

## Contributing ##

We welcome contributions!  Please see
[`CONTRIBUTING.md`](../CONTRIBUTING.md) for details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
