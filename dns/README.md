# cool-accounts - dns subdirectory #

This subdirectory contains Terraform code to provision the COOL DNS
account.  It creates an IAM role that allows sufficient permissions to
provision all AWS resources in this account.  This role has a trust
relationship with the Users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because there is
no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the COOL DNS
account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `profile = "cool-dns-provisionaccount"` line for
   the "default" provider in `providers.tf` and directly below that
   uncomment the line `profile = "cool-dns-account-admin"`.
1. Create a new AWS profile called `cool-dns-account-admin`
   in your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL dns account:

   ```console
   [cool-dns-account-admin]
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
     Application = "COOL - DNS Account"
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
| [aws_iam_policy.provisionpublishegressip_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.provisionroute53_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.provisionpublishegressip_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.provisionpublishegressip_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.provisionroute53_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_delegation_set.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_delegation_set) | resource |
| [aws_caller_identity.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisionpublishegressip_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisionroute53_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region where the non-global resources for the DNS account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the DNS account. | `string` | `"Allows sufficient permissions to provision all AWS resources in the DNS account."` | no |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the DNS account. | `string` | `"ProvisionAccount"` | no |
| provisionpublishegressip\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account. | `string` | `"Allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."` | no |
| provisionpublishegressip\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account. | `string` | `"ProvisionPublishEgressIP"` | no |
| provisionroute53\_role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision Route 53 in the DNS account. | `string` | `"Allows sufficient permissions to provision Route 53 in the DNS account."` | no |
| provisionroute53\_role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision Route 53 in the DNS account. | `string` | `"ProvisionRoute53"` | no |
| publishegressip\_lambda\_name | The name of the Lambda function used in cisagov/publish-egress-ip-terraform.  This name is used to specify resource constraints in the role/policy specified in var.provisionpublishegressip\_role\_name. | `string` | `"publish-egress-ip"` | no |
| publishegressip\_role\_name | The name of the IAM role (meant to be used in cisagov/publish-egress-ip-terraform) that is allowed to be created by the role/policy specified in var.provisionpublishegressip\_role\_name. | `string` | `"PublishEgressIPLambda"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| cw\_alarm\_sns\_topic | The SNS topic to which a message is sent when a CloudWatch alarm is triggered. |
| primary\_delegation\_set | The primary reusable delegation set that contains the authoritative name servers for all public DNS zones. |
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in the DNS account. |
| provisionpublishegressip\_role | The IAM role that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account. |

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
