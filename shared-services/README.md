# cool-accounts - shared-services subdirectory #

This subdirectory contains Terraform code to provision the COOL
"shared services" account.  It creates an IAM role that allows
sufficient permissions to provision all AWS resources in this account.
This role has a trust relationship with the users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because there is
no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the COOL Shared
Services account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `profile = "cool-sharedservices-provisionaccount"`
   line for the "default" provider in `providers.tf` and directly
   below that uncomment the line `profile =
   "cool-sharedservices-account-admin"`.
1. Create a new AWS profile called `cool-sharedservices-account-admin`
   in your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL Shared Services account:

   ```console
   [cool-sharedservices-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
   variables (see [Inputs](#Inputs) below for details):

   ```console
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

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_region | The AWS region where the non-global resources for the Shared Services account are to be provisioned (e.g. "us-east-1"). | `string` | `us-east-1` | no |
| provisionaccount_role_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account. | `string` | `Allows sufficient permissions to provision all AWS resources in the Shared Services account.` | no |
| provisionaccount_role_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account. | `string` | `ProvisionAccount` | no |
| provisionssmdocument_policy_description | The description to associate with the IAM policy that allows sufficient permissions to provision the SSM Document resource in the Shared Services account. | `string` | `Allows sufficient permissions to provision the SSM Document resource in the Shared Services account.` | no |
| provisionssmdocument_policy_name | The name to assign the IAM policy that allows sufficient permissions to provision the SSM Document resource in the Shared Services account. | `string` | `ProvisionSSMDocument` | no |
| ssmsession_role_description | The description to associate with the IAM role (and policy) that allows creation of SSM SessionManager sessions to any EC2 instance in this account. | `string` | `Allows creation of SSM SessionManager sessions to any EC2 instance in this account.` | no |
| ssmsession_role_name | The name to assign the IAM role (and policy) that allows creation of SSM SessionManager sessions to any EC2 instance in this account. | `string` | `StartStopSSMSession` | no |
| tags | Tags to apply to all AWS resources provisioned. | `map(string)` | `{}` | no |
| users_account_id | The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the Shared Services account. | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| provisionaccount_role | The IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account. |
| ssmsession_role | The IAM role that allows creation of SSM SessionManager sessions to any EC2 instance in this account. |

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
