# cool-accounts - dynamic subdirectory #

This subdirectory contains Terraform code to provision a dynamic
(i.e. non-static) COOL account.  It creates an IAM role that allows
sufficient permissions to provision all AWS resources in the account.
This role has a trust relationship with the Users account.

## Bootstrapping this account ##

Note that the dynamic account must be bootstrapped.  This is because
there is no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the dynamic
COOL account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `profile =
   "cool-${var.dynamic_account_name}-provisionaccount"` line for the
   "default" provider in `providers.tf` and directly below that
   uncomment the line `profile =
   "cool-${var.dynamic_account_name}-account-admin"`.
1. Create a new AWS profile called
   `cool-<DYNAMIC_ACCOUNT_NAME>-account-admin` (replacing
   `<DYNAMIC_ACCOUNT_NAME>` with the actual name of the account) in
   your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL dynamic account:

   ```console
   [cool-<DYNAMIC_ACCOUNT_NAME>-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Ensure that the bucket name in `backend.tf` is correct.  It should match
   the `state_bucket_name` specified in the `tfvars` file that you used to
   bootstrap the [`cool-accounts/terraform`](../terraform) directory.
1. Run the command `terraform init -upgrade`.  Note that if you have previously
   used a different Terraform backend (e.g. for a different environment), you
   will need to run `terraform init -reconfigure -upgrade`.
1. Create a Terraform workspace (if you haven't already done so) by
   running `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file in
   [cisagov/cool-tf-vars](https://github.com/cisagov/cool-tf-vars)
   with all of the required variables (see [Inputs](#inputs) below for
   details):

   ```console
   dynamic_account_name = "env0"

   tags = {
     Application       = "COOL - env0 Production Account"
     AssessmentAccount = "true"
     Team              = "VM Fusion - Development"
     Workspace         = "env0-production"
   }
   ```

1. Run the command `terraform apply -var-file=<workspace_name>.tfvars`.
1. Revert the changes you made to `providers.tf` in step 1.
1. Run the command `terraform apply -var-file=<workspace_name>.tfvars`.

At this point the account has been bootstrapped, and you can apply
future changes by simply running `terraform apply
-var-file=<workspace_name>.tfvars`.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |
| aws.organizationsreadonly | ~> 3.38 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| cw\_alarm\_sns | github.com/cisagov/cw-alarm-sns-tf-module | n/a |
| provisionaccount | github.com/cisagov/provisionaccount-role-tf-module | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_policy.ec2readonly_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2readonly_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2readonly_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_dns_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ec2readonly_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region where the non-global resources for the dynamic account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| dynamic\_account\_name | The name of the dynamic account to be provisioned. | `string` | n/a | yes |
| ec2readonly\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows read access to some EC2 attributes in the dynamic account. | `string` | `"Allows read access to some EC2 attributes in the dynamic account."` | no |
| ec2readonly\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows read access to some EC2 attributes in the dynamic account. | `string` | `"EC2ReadOnly"` | no |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the dynamic account. | `string` | `"Allows sufficient permissions to provision all AWS resources in the dynamic account."` | no |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the dynamic account. | `string` | `"ProvisionAccount"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| cw\_alarm\_sns\_topic | The SNS topic to which a message is sent when a CloudWatch alarm is triggered. |
| ec2readonly\_role | The IAM role that allows read access to some EC2 attributes in the dynamic account. |
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in the dynamic account. |

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
