# cool-accounts - users subdirectory #

This subdirectory contains Terraform code to create the COOL
"users" account.  It creates:

* IAM user(s) with the ability to administer their own credentials (including
  multi-factor authentication).
* An IAM group containing the user(s) above and an IAM policy that allows
  them to assume a role that can access the Terraform backend (set up via
  the terraform subdirectory of this project).

## Bootstrapping this account ##

Note that this account must be bootstrapped after the "terraform"
account.  This is because initially there are no resources in this
account that can access the remote shared Terraform state, and
also because there is no IAM role that can be assumed to build out
those resources.  Therefore you must first apply this Terraform code
with:

* No backend configuration, so that the state is created locally.
* Using programmatic credentials for AWSAdministratorAccess as
  obtained for the COOL "users" account from the AWS SSO page.

To do this, follow these steps:

1. Comment out all the content in the `backend.tf` file.
1. Comment out the `assume_role` block in `provider.tf` and directly
   below that uncomment the line `profile = "cool-users-account-admin"`.
1. Create a new AWS profile called `cool-users-account-admin` in
   your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL "users" account:

   ```console
   [cool-users-account-admin]
   aws_access_key_id = <ACCESS_KEY_ID>
   aws_secret_access_key = <SECRET_ACCESS_KEY>
   aws_session_token = <SESSION_TOKEN>
   ```

1. Create a `<workspace_name>.tfvars` file with all of the required
  variables (see [Inputs](#Inputs) below for details).  Note that
  `access_backend_terraform_role_arn` is the `backend_role_arn` output
  from the bootstrapping the terraform subdirectory:

  ```console
  access_terraform_backend_role_arn = "arn:aws:iam::111111111111:role/AccessTerraformBackend"
  this_account_id = "222222222222"
  usernames = [
    "user.one",
    "user.two"
  ]
  ```

1. Run the command `terraform init`.
1. Run the command `terraform apply
   -var-file=<workspace_name>.tfvars`.
1. Make sure that the analogs of steps 1-6 have been done with the
   "terraform" account.
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
| access_backend_terraform_role_arn | The ARN of the role that allows access to the Terraform backend | string | | yes |
| assume_access_terraform_backend_policy_description | The description to associate with the IAM policy that allows assumption of the role with access to the Terraform backend | string | `Allow assumption of the AccessTerraformBackend role in the Terraform account.` | no |
| assume_access_terraform_backend_policy_name | The name to assign the IAM policy that allows assumption of the role with access to the Terraform backend | string | `Terraform-AssumeAccessTerraformBackend` | no |
| assume_iam_admin_policy_description | The description to associate with the IAM policy that allows assumption of the role to become an IAM admininistrator | string | `Allow assumption of the IamAdministrator role.` | no |
| assume_iam_admin_policy_name | The name to assign the IAM policy that allows assumption of the role to become an IAM admininistrator | string | `AssumeIamAdministrator` | no |
| aws_region | The AWS region where the non-global resources for this account are to be created (e.g. us-east-1) | string | `us-east-1` | no |
| iam_admin_role_description | The description to associate with the IAM role that allows full IAM administrator access in this account | string | `Allows full IAM administrator access in this account.` | no |
| iam_admin_role_name | The name to assign the IAM role that allows full IAM administrator access in this account | string | `IamAdministrator` | no |
| usernames | The usernames associated with the accounts to be created and allowed to access the terraform backend, as well as become IAM administrators.  The format first.last is recommended. | string | | yes |
| terraform_backend_users_group | The name of the group to be created for users allowed to access the terraform backend | string | `terraform_backend_users` | no |
| tags | Tags to apply to all AWS resources created | map(string) | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| iam_admin_role_arn | The ARN of the IAM role that allows full IAM administrator access in this account |

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