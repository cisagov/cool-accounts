# cool-accounts - audit subdirectory #

This subdirectory contains Terraform code to provision the COOL
"audit" account.  It creates an IAM role that allows sufficient
permissions to provision all AWS resources in this account.  This role
has a trust relationship with the users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because there is
no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the COOL Audit
account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `profile = "cool-audit-provisionaccount"` line for
   the "default" provider in `providers.tf` and directly below that
   uncomment the line `profile = "cool-audit-account-admin"`.
1. Create a new AWS profile called `cool-audit-account-admin`
   in your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL audit account:

   ```console
   [cool-audit-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
   variables (see [Inputs](#Inputs) below for details):

   ```console
   this_account_id  = "111111111111"
   users_account_id = "222222222222"

   admin_usernames = [
     "first.last",
     "first2.last2"
   ]
   ```

1. Run the command `terraform init`.
1. Run the command `terraform apply
   -var-file=<workspace_name>.tfvars`.
1. Revert the changes you made to `providers.tf` in step 1.
1. Run the command `terraform apply
    -var-file=<workspace_name>.tfvars`.

At this point the account has been bootstrapped, and you can apply
future changes by simply running `terraform apply
-var-file=<workspace_name>.tfvars`.

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| aws_region | The AWS region where the non-global resources for the Audit account are to be created (e.g. us-east-1). | string | `us-east-1` | no |
| provisionaccount_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to provision all AWS resources in the Audit account. | string | `Allows sufficient access to provision all AWS resources in the Audit account.` | no |
| provisionaccount_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all AWS resources in the Audit account. | string | `ProvisionAccount` | no |
| tags | Tags to apply to all AWS resources created. | map(string) | `{}` | no |
| users_account_id | The ID of the users account.  This account will be allowed to assume the role that allows sufficient access to provision all AWS resources in the Audit account. | string | | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| provisionaccount_role_arn | The ARN of the IAM role that allows sufficient permissions to create all AWS resources in the Audit account. |

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
