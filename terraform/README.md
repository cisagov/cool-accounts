# cool-accounts - terraform subdirectory #

This subdirectory contains Terraform code to provision the COOL
Terraform account.  It creates:

- The S3 bucket used to store Terraform state.
- The DynamoDB table used for Terraform state locking.
- An IAM role that allows sufficient access to the Terraform S3 bucket
  and DynamoDB table to use those resources as a Terraform backend.
  This role also has a trust relationship with the Users account.
- An IAM role that allows sufficient permissions to provision all AWS
  resources in this account.  This role has a trust relationship with
  the Users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because
initially there are no resources in this account that can be used to
host remote shared Terraform state, and also because there is no IAM
role that can be assumed to build out these resources.  Therefore you
must first apply this Terraform code with:

- No backend configuration, so that the state is created locally.
- Using programmatic credentials for AWSAdministratorAccess as
  obtained for the COOL Terraform and Users accounts from the AWS SSO
  page.

To do this, follow these steps:

1. Comment out all the content in the `backend.tf` file.
1. Comment out the `profile = "cool-terraform-provisionaccount"` line
   for the "default" provider in `providers.tf` and directly below
   that uncomment the line `profile = "cool-terraform-account-admin"`.
1. Comment out the `profile = "cool-master-organizationsreadonly"` line
   for the "organizationsreadonly" provider in `providers.tf` and directly
   below that uncomment the line `profile = "cool-master-account-admin"`.
1. Create a new AWS profile called `cool-terraform-account-admin` in
   your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL Terraform account:

   ```console
   [cool-terraform-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Create a new AWS profile called `cool-master-account-admin` in
   your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL Master account:

   ```console
   [cool-master-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Run the command `terraform init -upgrade`.  Note that if you have previously
   used a different Terraform backend (e.g. for a different environment), you
   will need to run `terraform init -reconfigure -upgrade`.
1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
   variables and any optional variables that you want to override (see
   [Inputs](#inputs) below for details):

   ```hcl
   state_bucket_name = "my-terraform-state-bucket"
   tags = {
     Team        = "VM Fusion - Development"
     Application = "COOL - Terraform Account"
     Workspace   = "production"
   }
   ```

1. Run the command `terraform apply -var-file=<workspace_name>.tfvars`.
1. Revert the changes you made to `backend.tf` in step 1.
1. Edit the bucket name in `backend.tf` to match the `state_bucket_name`
   variable in your `<workspace_name>.tfvars` file.
1. Comment out the `profile = "cool-terraform-backend"` line
   in `backend.tf` and directly below that uncomment the line
   `profile = "cool-terraform-account-admin"`.
1. Revert the changes you made to `provider.tf` in step 2.  Give yourself
   a reminder to revert the changes you made to `provider.tf` in step 3 after
   you bootstrap the Master account.
1. Run the command `terraform init`.  When Terraform asks 'Do you want to
   migrate all workspaces to "s3"?', enter "yes".
1. Run the command `terraform apply -var-file=<workspace_name>.tfvars`.

At this point the account has been bootstrapped, and you can apply
future changes by simply running `terraform apply
-var-file=<workspace_name>.tfvars`.  You can also now delete the
`cool-terraform-account-admin` AWS profile that you created in step 4.  Give
yourself a reminder to revert the changes you made to `backend.tf` in step 12
after you bootstrap the Users account.

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 4.9 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 4.9 |
| aws.organizationsreadonly | ~> 4.9 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| cw\_alarm\_sns | github.com/cisagov/sns-send-to-account-email-tf-module | n/a |
| user\_group\_mod\_event | github.com/cisagov/user-group-mod-alert-tf-module | n/a |
| user\_group\_mod\_sns | github.com/cisagov/sns-send-to-account-email-tf-module | n/a |
| provisionaccount | github.com/cisagov/provisionaccount-role-tf-module | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_dynamodb_table.state_lock_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy.access_domainmanager_terraform_backend_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.access_pca_terraform_backend_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.access_terraform_backend_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.provisionbackend_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_terraform_state_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.access_domainmanager_terraform_backend_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.access_pca_terraform_backend_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.access_terraform_backend_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.read_terraform_state_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.access_domainmanager_terraform_backend_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.access_pca_terraform_backend_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.access_terraform_backend_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.provisionbackend_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read_terraform_state_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.state_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.state_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_caller_identity.terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.access_domainmanager_terraform_backend_access_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.access_pca_terraform_backend_access_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.access_terraform_backend_access_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisionbackend_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_terraform_state_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_topic_access_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_domainmanager\_terraform\_backend\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `"Allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."` | no |
| access\_domainmanager\_terraform\_backend\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `"AccessDomainManagerTerraformBackend"` | no |
| access\_pca\_terraform\_backend\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `"Allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."` | no |
| access\_pca\_terraform\_backend\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `"AccessPCATerraformBackend"` | no |
| access\_terraform\_backend\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `"Allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."` | no |
| access\_terraform\_backend\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. | `string` | `"AccessTerraformBackend"` | no |
| aws\_region | The AWS region where the non-global resources for this account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| domainmanager\_terraform\_projects | The list of project names that contain Domain Manager-related Terraform code (e.g. ["my-domain-manager-project"]). | `list(string)` | `[]` | no |
| pca\_terraform\_projects | The list of project names that contain PCA-related Terraform code (e.g. ["my-pca-project"]). | `list(string)` | `[]` | no |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account. | `string` | `"Allows sufficient permissions to provision all AWS resources in the Terraform account."` | no |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account. | `string` | `"ProvisionAccount"` | no |
| provisionbackend\_policy\_description | The description to associate with the IAM policy that allows sufficient permissions to provision the Terraform backend resources in the Terraform account. | `string` | `"Allows sufficient permissions to provision the Terraform backend resources in the Terraform account."` | no |
| provisionbackend\_policy\_name | The name to assign the IAM policy that allows sufficient permissions to provision the Terraform backend resources in the Terraform account. | `string` | `"ProvisionBackend"` | no |
| read\_terraform\_state\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored. | `string` | `"Allows read-only access to the S3 bucket where Terraform state is stored."` | no |
| read\_terraform\_state\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored. | `string` | `"ReadTerraformState"` | no |
| state\_bucket\_name | The name to use for the S3 bucket that will store the Terraform state. | `string` | n/a | yes |
| state\_table\_name | The name to use for the DynamoDB table that will be used for Terraform state locking. | `string` | `"terraform-state-lock"` | no |
| state\_table\_read\_capacity | The number of read units for the DynamoDB table that will be used for Terraform state locking. | `number` | `20` | no |
| state\_table\_write\_capacity | The number of write units for the DynamoDB table that will be used for Terraform state locking. | `number` | `20` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| access\_domainmanager\_terraform\_backend\_role | The IAM role that allows sufficient access to the the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. |
| access\_pca\_terraform\_backend\_role | The IAM role that allows sufficient access to the the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. |
| access\_terraform\_backend\_role | The IAM role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend. |
| cw\_alarm\_sns\_topic | The SNS topic to which a message is sent when a CloudWatch alarm is triggered. |
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account. |
| read\_terraform\_state\_role | The IAM role that allows read-only access to the S3 bucket where Terraform state is stored. |
| state\_bucket | The S3 bucket where Terraform state information will be stored. |
| state\_lock\_table | The DynamoDB table that to be used for Terraform state locking. |
<!-- END_TF_DOCS -->

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
