# cool-accounts - images subdirectory #

This subdirectory contains Terraform code to provision the COOL
"Images" account.  It creates:

- An IAM role that allows sufficient permissions to provision all AWS
  resources in this account.  This role has a trust relationship with
  the Users account.
- An IAM role that allows sufficient permissions to create AWS EC2
  AMIs in this account.  This role has a trust relationship with the
  Users account.

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
   as obtained from the COOL Images account:

   ```console
   [cool-images-account-admin]
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
   that you wish to override (see [Inputs](#Inputs) below for
   details):

   ```console
   tags = {
     Team        = "VM Fusion - Development"
     Application = "COOL - Images Account"
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
| [aws_default_route_table.ami_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_iam_policy.administerkmskeys_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ec2amicreate_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.provisionec2amicreateroles_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.provisionkmskeys_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.provisionthirdpartybucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.provisionthirdpartybucketreadroles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.provisionvpcs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.administerkmskeys_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ec2amicreate_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.provisionec2amicreateroles_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.provisionthirdpartybucketreadroles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.administerkmskeys_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2amicreate_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.provisionec2amicreateroles_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.provisionkmskeys_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.provisionthirdpartybucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.provisionthirdpartybucketreadroles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.provisionvpcs_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_internet_gateway.ami_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_kms_alias.amis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.amis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_network_acl.ami_build_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_rule.ami_build_public_egress_to_anywhere_via_any_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ami_build_public_ingress_from_anywhere_via_ephemeral_ports](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ami_build_public_ingress_from_anywhere_via_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route.external_traffic_through_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_s3_bucket.third_party](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.third_party](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_security_group.windows_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.windows_ami_egress_to_anywhere](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.windows_ami_ingress_via_rdp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.ami_build_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.ami_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_caller_identity.images](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.administerkmskeys_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ami_kms_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ec2amicreate_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisionec2amicreateroles_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisionkmskeys_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisionthirdpartybucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisionthirdpartybucketreadroles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisionvpcs_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| administerkmskeys\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer all KMS keys in the Images account. | `string` | `"Allows sufficient permissions to administer all KMS keys in the Images account."` | no |
| administerkmskeys\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer all KMS keys in the Images account. | `string` | `"AdministerKMSKeys"` | no |
| ami\_build\_cidr | The CIDR block to assign to the VPC and subnet used to build AMIs. | `string` | `"192.168.100.0/24"` | no |
| ami\_kms\_key\_alias | The alias to assign to the KMS key used to encrypt AMIs in the Images account. | `string` | `"cool-amis"` | no |
| ami\_kms\_key\_description | The description to assign to the KMS key used to encrypt AMIs in the Images account. | `string` | `"The key used to encrypt AMIs in this account."` | no |
| aws\_region | The AWS region where the non-global resources for the Images account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| ec2amicreate\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account. | `string` | `"Allows sufficient permissions to create AMIs in the Images account."` | no |
| ec2amicreate\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account. | `string` | `"EC2AMICreate"` | no |
| extraorg\_account\_ids | A list of AWS account IDs corresponding to "extra" accounts that you want to allow to launch EC2 instances using one or more AMIs in this account (e.g. ["123456789012"]).  The ProvisionAccount role in these accounts will be allowed sufficient permissions to use the AMI encryption KMS key to launch instances.  Normally this variable is used to allow accounts that are not a member of the same AWS Organization as this account to use one or more AMIs from this account. | `list(string)` | `[]` | no |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Images account. | `string` | `"Allows sufficient permissions to provision all AWS resources in the Images account."` | no |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Images account. | `string` | `"ProvisionAccount"` | no |
| provisionec2amicreateroles\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can create AMIs in the Images account. | `string` | `"Allows creation of IAM roles that can create AMIs in the Images account."` | no |
| provisionec2amicreateroles\_role\_name | The name to assign the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can create AMIs in the Images account. | `string` | `"ProvisionEC2AMICreateRoles"` | no |
| provisionkmskeys\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision KMS keys in the Images account. | `string` | `"Allows sufficient permissions to provision KMS keys in the Images account."` | no |
| provisionkmskeys\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision KMS keys in the Images account. | `string` | `"ProvisionKMSKeys"` | no |
| provisionthirdpartybucket\_policy\_description | The description to associate with the IAM policy that allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account. | `string` | `"Allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account."` | no |
| provisionthirdpartybucket\_policy\_name | The name to assign the IAM policy that allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account. | `string` | `"ProvisionThirdPartyBucket"` | no |
| provisionthirdpartybucketreadroles\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can read objects in the third-party file storage S3 bucket in the Images account. | `string` | `"Allows creation of IAM roles that can read objects in the third-party file storage S3 bucket in the Images account."` | no |
| provisionthirdpartybucketreadroles\_role\_name | The name to assign the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can read objects in the third-party file storage S3 bucket in the Images account. | `string` | `"ProvisionThirdPartyBucketReadRoles"` | no |
| provisionvpcs\_policy\_description | The description to associate with the IAM policy that allows sufficient permissions to provision VPCs (and related resources) in the Images account. | `string` | `"Allows sufficient permissions to provision VPCs (and related resources) in the Images account."` | no |
| provisionvpcs\_policy\_name | The name to assign the IAM policy that allows sufficient permissions to provision VPCs (and related resources) in the Images account. | `string` | `"ProvisionVPCs"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| third\_party\_bucket\_name\_prefix | The prefix to use to name the S3 bucket for storing third-party files.  The bucket will be named with this prefix plus the account type (e.g. production or staging). | `string` | `"cisa-cool-third-party"` | no |
| windows\_ami\_sg\_name | The name to associate with the security group that allows access for finalizing Windows AMI configuration. | `string` | `"WindowsAMIBuild"` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| administerkmskeys\_role | The IAM role that allows sufficient permissions to administer KMS keys in the Images account. |
| ami\_kms\_key | The KMS key for encrypting AMIs in the Images account. |
| cw\_alarm\_sns\_topic | The SNS topic to which a message is sent when a CloudWatch alarm is triggered. |
| ec2amicreate\_role | The IAM role that allows sufficient permissions to create AMIs in the Images account. |
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in the Images account. |
| provisionec2amicreateroles\_role | The IAM role that allows sufficient permissions to provision IAM roles that can create AMIs in the Images account. |
| provisionthirdpartybucketreadroles\_role | The IAM role that allows sufficient permissions to provision IAM roles that can read objects in the third-party file storage S3 bucket in the Images account. |
| third\_party\_bucket | The S3 bucket for storing third-party files. |

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
