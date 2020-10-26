# cool-accounts - images subdirectory #

This subdirectory contains Terraform code to provision the COOL
"images" account.  It creates:

* An IAM role that allows sufficient permissions to provision all AWS
  resources in this account.  This role has a trust relationship with
  the users account.
* An IAM role that allows sufficient permissions to create AWS EC2
  AMIs in this account.  This role has a trust relationship with the
  users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because there is
no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the COOL Images
account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `profile = "cool-images-provisionaccount"` line for
   the "default" provider in `providers.tf` and directly below that
   uncomment the line `profile = "cool-images-account-admin"`.
1. Create a new AWS profile called `cool-images-account-admin`
   in your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL images account:

   ```console
   [cool-images-account-admin]
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
| aws | ~> 3.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| aws.organizationsreadonly | ~> 3.0 |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| administerkmskeys_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer all KMS keys in the Images account. | `string` | `Allows sufficient permissions to administer all KMS keys in the Images account.` | no |
| administerkmskeys_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer all KMS keys in the Images account. | `string` | `AdministerKMSKeys` | no |
| ami_build_cidr | The CIDR block to assign to the VPC and subnet used to build AMIs. | `string` | `192.168.100.0/24` | no |
| ami_kms_key_alias | The alias to assign to the KMS key used to encrypt AMIs in the Images account. | `string` | `cool-amis` | no |
| ami_kms_key_description | The description to assign to the KMS key used to encrypt AMIs in the Images account. | `string` | `The key used to encrypt AMIs in this account.` | no |
| aws_region | The AWS region where the non-global resources for the Images account are to be provisioned (e.g. "us-east-1"). | `string` | `us-east-1` | no |
| ec2amicreate_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account. | `string` | `Allows sufficient permissions to create AMIs in the Images account.` | no |
| ec2amicreate_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account. | `string` | `EC2AMICreate` | no |
| provisionaccount_role_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Images account. | `string` | `Allows sufficient permissions to provision all AWS resources in the Images account.` | no |
| provisionaccount_role_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Images account. | `string` | `ProvisionAccount` | no |
| provisionec2amicreateroles_role_description | The description to associate with the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can create AMIs in the Images account. | `string` | `Allows creation of IAM roles that can create AMIs in the Images account.` | no |
| provisionec2amicreateroles_role_name | The name to assign the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can create AMIs in the Images account. | `string` | `ProvisionEC2AMICreateRoles` | no |
| provisionkmskeys_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision KMS keys in the Images account. | `string` | `Allows sufficient permissions to provision KMS keys in the Images account.` | no |
| provisionkmskeys_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision KMS keys in the Images account. | `string` | `ProvisionKMSKeys` | no |
| provisionthirdpartybucket_policy_description | The description to associate with the IAM policy that allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account. | `string` | `Allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account.` | no |
| provisionthirdpartybucket_policy_name | The name to assign the IAM policy that allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account. | `string` | `ProvisionThirdPartyBucket` | no |
| provisionthirdpartybucketreadroles_role_description | The description to associate with the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can read objects in the third-party file storage S3 bucket in the Images account. | `string` | `Allows creation of IAM roles that can read objects in the third-party file storage S3 bucket in the Images account.` | no |
| provisionthirdpartybucketreadroles_role_name | The name to assign the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can read objects in the third-party file storage S3 bucket in the Images account. | `string` | `ProvisionThirdPartyBucketReadRoles` | no |
| provisionvpcs_policy_description | The description to associate with the IAM policy that allows sufficient permissions to provision VPCs (and related resources) in the Images account. | `string` | `Allows sufficient permissions to provision VPCs (and related resources) in the Images account.` | no |
| provisionvpcs_policy_name | The name to assign the IAM policy that allows sufficient permissions to provision VPCs (and related resources) in the Images account. | `string` | `ProvisionVPCs` | no |
| tags | Tags to apply to all AWS resources provisioned. | `map(string)` | `{}` | no |
| third_party_bucket_name_prefix | The prefix to use to name the S3 bucket for storing third-party files.  The bucket will be named with this prefix plus the account type (e.g. production or staging). | `string` | `cisa-cool-third-party` | no |
| users_account_id | The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the Images account. | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| administerkmskeys_role | The IAM role that allows sufficient permissions to administer KMS keys in the Images account. |
| ami_kms_key | The KMS key for encrypting AMIs in the Images account. |
| ec2amicreate_role | The IAM role that allows sufficient permissions to create AMIs in the Images account. |
| provisionaccount_role | The IAM role that allows sufficient permissions to provision all AWS resources in the Images account. |
| provisionec2amicreateroles_role | The IAM role that allows sufficient permissions to provision IAM roles that can create AMIs in the Images account. |
| provisionthirdpartybucketreadroles_role | The IAM role that allows sufficient permissions to provision IAM roles that can read objects in the third-party file storage S3 bucket in the Images account. |
| third_party_bucket | The S3 bucket for storing third-party files. |

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
