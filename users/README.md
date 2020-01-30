# Users account #

This directory contains Terraform code that can be used to configure the Users
account in the COOL environment.

## Usage ##

Coming soon!

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| access_backend_terraform_role_arn | The ARN of the role that allows access to the Terraform backend | string | | yes |
| assume_access_terraform_backend_policy_description | The description to associate with the IAM policy that allows assumption of the role with access to the Terraform backend | string | Allow assumption of the AccessTerraformBackend role in the Terraform account. | no |
| assume_access_terraform_backend_policy_name | The name to assign the IAM policy that allows assumption of the role with access to the Terraform backend | string | Terraform-AssumeAccessTerraformBackend | no |
| usernames | The usernames associated with the accounts to be created and allowed to access the terraform backend, as well as be IAM administrators.  The format first.last is recommended. | string | | yes |
| terraform_backend_users_group | The name of the group to be created for users allowed to access the terraform backend | string | usernames | no |
| tags | Tags to apply to all AWS resources created | map(string) | `{}` | no |

## Outputs ##

None

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
