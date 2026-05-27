# cool-accounts - log-archive subdirectory #

This subdirectory contains Terraform code to provision the COOL Log Archive
account.  It creates an IAM role that allows sufficient permissions to provision
all AWS resources in this account.  This role has a trust relationship with the
Users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because there is no IAM
role that can be assumed to build out these resources. Therefore you must first
apply this Terraform code with programmatic credentials for
AWSAdministratorAccess as obtained for the COOL Log Archive account from the AWS
SSO page.

To do this, follow these steps (for the purposes of these instructions, assume
the environment is named "dev"; replace "dev" in the instructions below with
your environment name if needed):

1. Comment out the `profile = "cool-logarchive-provisionaccount"` line for the
   "default" provider in `providers.tf` and directly below that uncomment the
   line `profile = "cool-logarchive-account-admin"`.
1. Create a new AWS profile called `cool-logarchive-account-admin` in your Boto3
   configuration using the "AWSAdministratorAccess" credentials (access key ID,
   secret access key, and session token) as obtained from the COOL Log Archive
   account:

   ```console
   [cool-logarchive-account-admin]
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Create a backend configuration file named `dev.tfconfig` containing the name
   of the bucket where Terraform state is stored for that environment.  The bucket
   name should match the `state_bucket_name` specified in the `tfvars` file that
   you used to bootstrap the [`cool-accounts/terraform`](../terraform)
   directory.  This file is required to initialize the Terraform backend in each
   environment:

    ```hcl
    bucket = "my-dev-terraform-state-bucket"
    ```

1. Initialize the Terraform backend for the "dev" environment using your backend
   configuration file:

    ```console
    terraform init -upgrade -backend-config=dev.tfconfig
    ```

    > [!NOTE]
    > When performing this step for additional environments (i.e. not your first
    > environment), use the `-reconfigure` flag:
    >
    > ```console
    > terraform init -upgrade -backend-config=other-env.tfconfig -reconfigure
    > ```

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new dev`
1. Create a `dev.tfvars` file with any optional variables
   that you wish to override (see [Inputs](#inputs) below for
   details):

   ```console
   tags = {
     Team        = "VM Fusion - Development"
     Application = "COOL - Log Archive Account"
     Workspace   = "dev"
   }
   ```

1. Run the command `terraform apply -var-file=dev.tfvars`.
1. Revert the changes you made to `providers.tf` in step 1.
1. If you haven't already done so, create a new AWS profile called
   `cool-logarchive-provisionaccount` in your local configuration that includes the
   `provisionaccount_role` ARN output from the previous step, for example:

   ```ini
   [cool-logarchive-provisionaccount]
   role_arn = arn:aws:iam::111111111111:role/ProvisionAccount
   role_session_name = your.session.name
   source_profile = cool-user-base-profile
   ```

1. Run the command `terraform apply -var-file=dev.tfvars`.

At this point the account has been bootstrapped, and you can apply future
changes by simply running `terraform apply -var-file=dev.tfvars`.

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
| ---- | ------- |
| terraform | ~> 1.1 |
| aws | ~> 6.7 |

## Providers ##

| Name | Version |
| ---- | ------- |
| aws | ~> 6.7 |
| aws.organizationsreadonly | ~> 6.7 |

## Modules ##

| Name | Source | Version |
| ---- | ------ | ------- |
| cw\_alarm\_sns | github.com/cisagov/sns-send-to-account-email-tf-module | n/a |
| disable-inactive-iam-users | github.com/cisagov/disable-inactive-iam-users-tf-module | n/a |
| provisionaccount | github.com/cisagov/provisionaccount-role-tf-module | n/a |
| user\_group\_mod\_event | github.com/cisagov/user-group-mod-alert-tf-module | n/a |
| user\_group\_mod\_sns | github.com/cisagov/sns-send-to-account-email-tf-module | n/a |
| wiz | tf.app.wiz.io/wiz/native-terraform/aws | ~> 1.0 |

## Resources ##

| Name | Type |
| ---- | ---- |
| [aws_iam_policy.read_lambda_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.read_lambda_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.read_lambda_bucket_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_topic_access_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| aws\_region | The AWS region where the non-global resources for the Log Archive account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| lambda\_bucket\_name | The name of the S3 bucket containing the Lambda function deployment package to disable inactive IAM users. | `string` | n/a | yes |
| lambda\_key | The S3 key associated with the Lambda function deployment package to disable inactive IAM users. | `string` | n/a | yes |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Log Archive account. | `string` | `"Allows sufficient permissions to provision all AWS resources in the Log Archive account."` | no |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Log Archive account. | `string` | `"ProvisionAccount"` | no |
| read\_lambda\_bucket\_policy\_description | The description to associate with the IAM role that allows read-only access to the bucket in the Terraform account containing Lambda deployments. | `string` | `"Allows read-only access to the bucket in the Terraform account containing Lambda deployments."` | no |
| read\_lambda\_bucket\_policy\_name | The name to assign the IAM policy that allows read-only access to the bucket in the Terraform account containing Lambda deployments. | `string` | `"LambdaBucketReadOnly"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| wiz\_external\_id | The external ID of the Wiz AWS Connector.  This value must be retrieved from the Wiz portal when creating the AWS Connector. | `string` | n/a | yes |
| wiz\_remote\_arn | The AWS Trust Policy Role ARN for your Wiz data center.  It can be retrieved from the Wiz portal (User Settings, Tenant). | `string` | n/a | yes |

## Outputs ##

| Name | Description |
| ---- | ----------- |
| cw\_alarm\_sns\_topic | The SNS topic to which a message is sent when a CloudWatch alarm is triggered. |
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in the Log Archive account. |
| wiz\_connector\_arn | The ARN of the IAM role created for the Wiz AWS connector. |
<!-- END_TF_DOCS -->

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
