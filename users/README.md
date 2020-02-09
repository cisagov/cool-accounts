# cool-accounts - users subdirectory #

This subdirectory contains Terraform code to provision the COOL
"users" account.  It creates:

* IAM user(s) with the ability to administer their own credentials (including
  multi-factor authentication).
* An IAM group containing the user(s) above and an IAM policy that allows
  them to assume a role that can access the Terraform backend (set up via
  the terraform subdirectory of this project).

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because because
there is no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the COOL
"users" account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `assume_role` block in `provider.tf` and directly
   below that uncomment the line `profile = "cool-users-account-admin"`.
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
   this_account_id = "236526679726"

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

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| admin_usernames | The usernames associated with the admin accounts to be created, which are allowed to access the terraform backend and are IAM administrators.  The format first.last is recommended.  The keys are the usernames and the values are empty strings (since they are not presently used). Example: { \"firstname1.lastname1\" = \"\",  \"firstname2.lastname2\" = \"\" } | map(string) | | yes |
| assume_provisionaccount_policy_description | The description to associate with the IAM policy that allows assumption of the role to provision all AWS resources in this account | string | `Allow assumption of the ProvisionAccount role.` | no |
| assume_provisionaccount_policy_name | The name to assign the IAM policy that allows assumption of the role to provision all AWS resources in this account | string | `AssumeProvisionAccount` | no |
| aws_region | The AWS region where the non-global resources for this account are to be provisioned (e.g. us-east-1) | string | `us-east-1` | no |
| provisionaccount_role_description | The description to associate with the IAM role that allows access to provision all AWS resources in this account | string | `Allows sufficient access to provision all AWS resources in this account.` | no |
| provisionaccount_role_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the users account | string | `ProvisionAccount` | no |
| tags | Tags to apply to all AWS resources created | map(string) | `{}` | no |
| this_account_id | The ID of the account being configured. | string | | yes |
| users_account_provisioners_group_name | The name of the group to be created for users allowed to provision the users account | string | `users_account_provisioners` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| provisionaccount_role_arn | The ARN of the IAM role that allows sufficient permissions to provision all AWS resources in this account |

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
