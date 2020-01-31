# cool-accounts - terraform subdirectory #

This subdirectory contains Terraform code to create the COOL
"terraform" account.  It creates:

* The S3 bucket used to store Terraform state.
* The DynamoDB table used for Terraform state locking.
* An IAM role that allows sufficient access to the Terraform S3 bucket
  and DynamoDB table to use those resources as a Terraform backend.
  This role also has a trust relationship with the users account.
* An IAM role that allows sufficient sufficient permissions to create
  all AWS resources in this account.  This role has a trust
  relationship with the users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped along with the "users"
account.  This is because initially there are no resources in this
account that can be used to host remote shared Terrafrom state, and
also because there is no IAM role that can be assumed to build out
these resources.  Therefore you must first apply this Terraform code
with:

* No backend configuration, so that the state is created locally.
* Using programmatic credentials for AWSAdministratorAccess as
  obtained for the COOL terraform account from the AWS SSO page.

To do this, follow these steps:

1. Comment out all the content in the `backend.tf` file.
1. Comment out the `assume_role` block in `provider.tf` and directly
   below that uncomment the line `profile =
   "cool-terraform-account-admin"`.
1. Create a new AWS profile called `cool-terraform-account-admin` in
   your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL terraform account:

   ```console
   [cool-terraform-account-admin]
   aws_access_key_id = <ACCESS_KEY_ID>
   aws_secret_access_key = <SECRET_ACCESS_KEY>
   aws_session_token = <SESSION_TOKEN>
   ```

1. Create a `<workspace_name>.tfvars` file with all of the required
   variables (see [Inputs](#Inputs) below for details):

   ```console
   this_account_id = "111111111111"
   user_account_id = "222222222222"
   ```

1. Run the command `terraform init`.
1. Run the command `terraform apply
   -var-file=<workspace_name>.tfvars`.
1. Make sure that the analogs of steps 1-6 have been done with the
   users account.
1. Revert the changes you made to `backend.tf` in step 1.
1. Revert the changes you made to `provider.tf` in step 2.
1. Run the command `terraform init`.
1. Run the command `terraform apply
    -var-file=<workspace_name>.tfvars`.

At this point the account has been bootstrapped, and you can apply
future changes by simply running `terraform apply
-var-file=<workspace_name>.tfvars`.

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| aws_region | The AWS region where the non-global resources for this account are to be created (e.g. us-east-1). | string | `us-east-1` | no |
| backend_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | string | `Allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend.` | no |
| backend_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | string | `AccessTerraformBackend` | no |
| create_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to create all AWS resources in this account. | string | `Allows sufficient access to create all AWS resources in this account` | no |
| create_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to create all AWS resources in the terraform account. | string | `CreateAccount` | no |
| state_bucket_name | The name to use for the S3 bucket that will store the Terraform state. | string | `cisa-cool-terraform-state` | no |
| state_table_name | The name to use for the DynamoDB table that will be used for Terraform state locking. | string | `terraform-state-lock` | no |
| state_table_read_capacity | The number of read units for the DynamoDB table that will be used for Terraform state locking. | number | `20` | no |
| state_table_write_capacity | The number of write units for the DynamoDB table that will be used for Terraform state locking. | number | `20` | no |
| tags | Tags to apply to all AWS resources created. | map(string) | `{}` | no |
| this_account_id | The ID of the account being configured. | string | | yes |
| user_account_id | The ID of the users account.  This account will be allowed to assume the role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | string | | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| backend_role_arn | The ARN of the IAM role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. |
| create_role_arn | The ARN of the IAM role that allows sufficient sufficient permissions to create all AWS resources in this account. |
| state_bucket_arn | The ARN of the S3 bucket where Terraform state information will be stored. |
| state_bucket_id | The ID of the S3 bucket where Terraform state information will be stored. |
| state_lock_table_arn | The ARN of the DynamoDB table that to be used for Terraform state locking. |
| state_lock_table_id | The ID of the DynamoDB table that to be used for Terraform state locking. |

## Contributing ##

We welcome contributions!  Please see [here](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
