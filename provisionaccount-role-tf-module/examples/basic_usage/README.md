# cool-accounts - Basic usage of provisionaccount-role-tf-module #

This subdirectory contains Terraform code to provision the COOL
"pettifogger0" account.  It creates:

* An IAM role that allows sufficient permissions to provision all AWS
  resources in this account.  This role has a trust relationship with
  the users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because there is
no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the COOL
Pettifogger0 account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `assume_role` block for the "default" provider in
   `providers.tf` and directly below that uncomment the line `profile
   = "cool-pettifogger0-account-admin"`.
1. Create a new AWS profile called `cool-pettifogger0-account-admin`
   in your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL pettifogger0 account:

   ```console
   [cool-pettifogger0-account-admin]
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
| account_provisioners_group_membership_name | The name to associate with the membership of the IAM group allowed to assume the role with sufficient permissions to provision the Pettifogger0 account. | string | `pettifogger0_account_provisioners_membership` | no |
| account_provisioners_group_name | The name to associate with the IAM group allowed to assume the role with sufficient permissions to provision the Pettifogger0 account. | string | `pettifogger0_account_provisioners` | no |
| admin_usernames | The usernames associated with the admin IAM user accounts. | list(string) | | yes |
| assume_provisionaccount_policy_description | The description to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the Pettifogger0 account. | string | `Allow assumption of the ProvisionAccount role in the Pettifogger0 account.` | no |
| assume_provisionaccount_policy_name | The name to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the Pettifogger0 account. | string | `Pettifogger0-AssumeProvisionAccount` | no |
| aws_region | The AWS region where the non-global resources for the Pettifogger0 account are to be created (e.g. us-east-1). | string | `us-east-1` | no |
| provisionaccount_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to provision all AWS resources in the Pettifogger0 account. | string | `Allows sufficient access to provision all AWS resources in the Pettifogger0 account.` | no |
| provisionaccount_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all AWS resources in Pettifogger0 account. | string | `ProvisionAccount` | no |
| tags | Tags to apply to all AWS resources created. | map(string) | `{}` | no |
| this_account_id | The ID of the account being configured. | string | | yes |
| users_account_id | The ID of the users account.  This account will be allowed to assume the role that allows sufficient access to provision all AWS resources in the Pettifogger0 account. | string | | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| account_provisioners_group_arn | The ARN of the IAM group that is allowed sufficient permissions to provision all AWS resources in the Pettifogger0 account. |
| provisionaccount_role_arn | The ARN of the IAM role that allows sufficient permissions to create all AWS resources in the Pettifogger0 account. |

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
