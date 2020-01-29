# cool-users-account #

[![GitHub Build Status](https://github.com/cisagov/cool-users-account/workflows/build/badge.svg)](https://github.com/cisagov/cool-users-account/actions)

This is a project that can be used to configure a Users account in the COOL
environment.

See [here](https://www.terraform.io/docs/modules/index.html) for more
details on Terraform modules and the standard module structure.

## Usage ##

Coming soon!

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| access_backend_terraform_role_arn | The ARN of the delegated role that allows access to the terraform backend | string | | yes |
| backend_terraform_users | The usernames associated with the accounts to be created and allowed to access the terraform backend.  The format first.last is recommended. | string | | yes |
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
