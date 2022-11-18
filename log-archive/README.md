# cool-accounts - log-archive subdirectory #

This subdirectory contains Terraform code to provision the COOL Log
Archive account.  It creates an IAM role that allows sufficient
permissions to provision all AWS resources in this account.  This role
has a trust relationship with the Users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because there is
no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the COOL Log
Archive account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `profile = "cool-logarchive-provisionaccount"` line
   for the "default" provider in `providers.tf` and directly below
   that uncomment the line `profile = "cool-logarchive-account-admin"`.
1. Create a new AWS profile called `cool-logarchive-account-admin`
   in your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL Log Archive account:

   ```console
   [cool-logarchive-account-admin]
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
1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with any optional variables
   that you wish to override (see [Inputs](#inputs) below for
   details):

   ```console
   tags = {
     Team        = "VM Fusion - Development"
     Application = "COOL - Log Archive Account"
     Workspace   = "production"
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
| aws.organizationsreadonly | ~> 3.38 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| cw\_alarm\_sns | github.com/cisagov/cw-alarm-sns-tf-module | n/a |
| provisionaccount | github.com/cisagov/provisionaccount-role-tf-module | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region where the non-global resources for the Log Archive account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Log Archive account. | `string` | `"Allows sufficient permissions to provision all AWS resources in the Log Archive account."` | no |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Log Archive account. | `string` | `"ProvisionAccount"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| cw\_alarm\_sns\_topic | The SNS topic to which a message is sent when a CloudWatch alarm is triggered. |
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in the Log Archive account. |

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
