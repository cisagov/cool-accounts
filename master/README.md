# cool-accounts - master subdirectory #

This subdirectory contains Terraform code to provision the COOL
"master" account.  It creates an IAM role that allows sufficient
permissions to provision all AWS resources in this account.  This role
has a trust relationship with the users account.

## Bootstrapping this account ##

Note that this account must be bootstrapped.  This is because there is
no IAM role that can be assumed to build out these resources.
Therefore you must first apply this Terraform code with programmatic
credentials for AWSAdministratorAccess as obtained for the COOL Master
account from the AWS SSO page.

To do this, follow these steps:

1. Comment out the `profile = "cool-master-provisionaccount"` line for
   the "default" provider in `providers.tf` and directly below that
   uncomment the line `profile = "cool-master-account-admin"`.
1. Create a new AWS profile called `cool-master-account-admin`
   in your Boto3 configuration using the "AWSAdministratorAccess"
   credentials (access key ID, secret access key, and session token)
   as obtained from the COOL master account:

   ```console
   [cool-master-account-admin]
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
| terraform | ~> 1.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| provisionaccount | github.com/cisagov/provisionaccount-role-tf-module | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_role.controltoweradmin_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.organizationsreadonly_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.admin_servicecatalog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.organizationsfullaccess_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.organizationsreadonly_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read_organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.servicecatalogadminfullaccess_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_servicecatalog_portfolio.control_tower](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicecatalog_portfolio) | resource |
| [aws_servicecatalog_principal_portfolio_association.control_tower_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicecatalog_principal_portfolio_association) | resource |
| [aws_iam_policy_document.additionalpermissions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_users_control_tower_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region where the non-global resources for the Master account are to be provisioned (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| controltoweradmin\_role\_description | The description to associate with the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account. | `string` | `"Allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."` | no |
| controltoweradmin\_role\_name | The name to assign the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account. | `string` | `"ControlTowerAdmin"` | no |
| organizationsreadonly\_role\_description | The description to associate with the IAM role that allows read-only access to all AWS Organizations information in the Master account. | `string` | `"Allows read-only access to all AWS Organizations information in the Master account."` | no |
| organizationsreadonly\_role\_name | The name to assign the IAM role that allows read-only access to all AWS Organizations information in the Master account. | `string` | `"OrganizationsReadOnly"` | no |
| provisionaccount\_role\_description | The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Master account. | `string` | `"Allows sufficient permissions to provision all AWS resources in the Master account."` | no |
| provisionaccount\_role\_name | The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Master account. | `string` | `"ProvisionAccount"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| controltoweradmin\_role | The IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account. |
| organizationsreadonly\_role | The IAM role that allows read-only access to all AWS Organizations information in the Master account. |
| provisionaccount\_role | The IAM role that allows sufficient permissions to provision all AWS resources in the Master account. |

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
