# cool-accounts - users subdirectory #

This subdirectory contains Terraform code to provision the COOL
"users" account.  It creates:

* IAM user(s) with the ability to administer their own credentials (including
  multi-factor authentication).
* An IAM group containing the user(s) above.  This group is allowed to
  access the terraform backend, be an IAM administrator for the Users
  account, and is allowed to assume any role that has a trust
  relationship with the Users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because because
there is no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the COOL
"users" account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `profile = "cool-users-provisionaccount"` line for
   the "default" provider in `providers.tf` and directly below that
   uncomment the line `profile = "cool-users-account-admin"`.
1. Create a new AWS profile called `cool-users-account-admin` in
   your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL "users" account:

   ```console
   [cool-users-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
   variables (see [Inputs](#Inputs) below for details).  Note that
   `access_backend_terraform_role_arn` is the `backend_role_arn` output
   from the bootstrapping the terraform subdirectory:

   ```console
   admin_usernames = [
     "user.one",
     "user.two"
   ]
   ```

1. Run the command `terraform init`.
1. Run the command `terraform apply
   -var-file=<workspace_name>.tfvars`.
1. Revert the changes you made to `provider.tf` in step 1.
1. Run the command `terraform apply
    -var-file=<workspace_name>.tfvars`.

At this point the account has been bootstrapped, and you can apply
future changes by simply running `terraform apply
-var-file=<workspace_name>.tfvars`.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| provisionaccount | github.com/cisagov/provisionaccount-role-tf-module |  |

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_group.gods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.assume_any_role_anywhere](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.assume_any_role_anywhere](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.self_managed_creds_with_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.self_managed_creds_without_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.gods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.gods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_policy_attachment.self_managed_creds_without_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_caller_identity.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_any_role_anywhere_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.self_managed_creds_with_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.self_managed_creds_without_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_any\_role\_anywhere\_policy\_description | The description to associate with the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account. | `string` | `"Allow assumption of any role in any account, so long as it has a trust relationship with the Users account."` | no |
| assume\_any\_role\_anywhere\_policy\_name | The name to assign the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account. | `string` | `"AssumeAnyRoleAnywhere"` | no |
| aws\_region | The AWS region where the non-global resources for this account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| godlike\_usernames | The usernames associated with the god-like accounts to be created, which are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account.  The format first.last is recommended.  Example: ["firstname1.lastname1",  "firstname2.lastname2"] | `list(string)` | n/a | yes |
| gods\_group\_name | The name of the group to be created for the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account. | `string` | `"gods"` | no |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows access to provision all AWS resources in the Users account. | `string` | `"Allows sufficient access to provision all AWS resources in the Users account."` | no |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Users account. | `string` | `"ProvisionAccount"` | no |
| self\_managed\_creds\_with\_mfa\_policy\_description | The description to associate with the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA). | `string` | `"Allows sufficient access for users to administer their own user accounts, requiring multi-factor authentication (MFA)."` | no |
| self\_managed\_creds\_with\_mfa\_policy\_name | The name to assign the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA). | `string` | `"SelfManagedCredsWithMFA"` | no |
| self\_managed\_creds\_without\_mfa\_policy\_description | The description to associate with the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA). | `string` | `"Allows sufficient access for users to administer their own user accounts, without requiring multi-factor authentication (MFA)."` | no |
| self\_managed\_creds\_without\_mfa\_policy\_name | The name to assign the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA). | `string` | `"SelfManagedCredsWithoutMFA"` | no |
| tags | Tags to apply to all AWS resources provisioned. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| assume\_any\_role\_anywhere\_policy | The IAM role that allows assumption of any role in any account, so long as it has a trust relationship with the Users account. |
| godlike\_users | The IAM users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account. |
| gods\_group | The IAM group containing the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account. |
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in this account. |
| selfmanagedcredswithmfa\_policy | The IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA). |
| selfmanagedcredswithoutmfa\_policy | The IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA). |

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
