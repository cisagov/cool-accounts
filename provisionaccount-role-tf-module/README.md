# cool-accounts - provisionaccount-role-tf-module #

This subdirectory contains Terraform code to perform the initial
provisioning of a COOL AWS account and get it in a state where it can
be further provisioned using IAM user credentials from the users
account.

This module creates an IAM role that allows sufficient permissions to
provision any IAM resources in this account, and this role has a trust
relationship with the users account so that it can be assumed via IAM
user credentials.

## Usage ##

```hcl
module "provisionaccount" {
  source = "../provisionaccount-role-tf-module"

  providers = {
    aws       = aws.dns
    aws.users = aws.users
  }

  account_provisioners_group_membership_name = "dns_account_provisioners_membership"
  account_provisioners_group_name            = "dns_account_provisioners"
  admin_usernames                            = ["john.smith", "max.musterman"]
  assume_provisionaccount_policy_description = "Allow assumption of the ProvisionAccount role in the DNS account."
  assume_provisionaccount_policy_name        = "DNS-AssumeProvisionAccount"
  new_account_id                             = var.this_account_id
  provisionaccount_role_description          = "Allows sufficient permissions to provision all AWS resources in the DNS account."
  provisionaccount_role_name                 = "ProvisionAccount"
  tags                                       = {
    Team        = "My Team"
    Application = "Sweet Application"
    Workspace   = "production"
  }
  users_account_id                           = var.users_account_id
}
```

## Examples ##

* [Basic usage](https://github.com/cisagov/cool-accounts/tree/develop/provisionaccount-role-tf-module/examples/basic_usage)

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| account_provisioners_group_membership_name | The name to associate with the membership of the IAM group allowed to assume the role with sufficient permissions to provision the new account (e.g. "dns_account_provisioners_membership"). | string | | yes |
| account_provisioners_group_name | The name to associate with the IAM group allowed to assume the role with sufficient permissions to provision the new account (e.g. "dns_account_provisioners"). | string | | yes |
| admin_usernames | The usernames associated with the admin IAM user accounts (e.g. ["first.last", "first2.last2"]).  Note that these user accounts will not be created and must exist. | list(string) | | yes |
| assume_provisionaccount_policy_description | The description to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the new account (e.g. "Allow assumption of the ProvisionAccount role in the DNS account"). | string | | yes |
| assume_provisionaccount_policy_name | The name to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the new account (e.g. "DNS-AssumeProvisionAccount"). | string | | yes |
| aws_region | The AWS region where the non-global resources for this account are to be created (e.g. us-east-1). | string | `us-east-1` | no |
| new_account_id | The ID of the account being configured. | string | | yes |
| provisionaccount_role_description | The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to provision all AWS resources in the new account (e.g. \Allows sufficient permissions to provision all AWS resources in the DNS account."). | string | | yes |
| provisionaccount_role_name | The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all AWS resources in the new account (e.g. "ProvisionAccount"). | string | | yes |
| tags | Tags to apply to all AWS resources created. | map(string) | `{}` | no |
| users_account_id | The ID of the users account.  This account will be allowed to assume the role that allows sufficient access to provision all AWS resources in the new account. | string | | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| account_provisioners_group_arn | The ARN of the IAM group that is allowed sufficient permissions to provision all AWS resources in the new account. |
| provisionaccount_role_arn | The ARN of the IAM role that allows sufficient permissions to provision all AWS resources in the new account. |
| provisionaccount_role_name | The name of the IAM role that allows sufficient permissions to provision all AWS resources in the new account. |

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
