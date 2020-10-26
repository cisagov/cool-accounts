# cool-accounts #

[![GitHub Build Status](https://github.com/cisagov/cool-accounts/workflows/build/badge.svg)](https://github.com/cisagov/cool-accounts/actions)

This project contains several directories of Terraform code to perform
the initial configuration of the COOL accounts, such as the
"terraform", "users", and "shared-services" accounts.  This Terraform
code creates and configures the most basic resources needed to build
out services and environments in the COOL organization, such as:

* An S3 bucket and a DynamoDB table for Terraform remote shared state.
* Roles that can be assumed by IAM user accounts to Terraform further
  environments and services.
* An initial set of user accounts so that developers can get started.

## Bootstrapping accounts ##

Note that all accounts must be bootstrapped.  This is because
initially there is no IAM role that can be assumed to build out these
resources.  Therefore for each account you must first apply the
Terraform code in the corresponding directory with:

* Using programmatic credentials for AWSAdministratorAccess as
  obtained for the COOL account from the AWS SSO page.

After this initial apply your desired IAM role will exist, and it will
be assumable from your IAM user that exists in the "users"
account. Therefore you can apply future changes using your IAM user
credentials.

The "terraform" and "users" accounts require even more special
attention.  The "terraform" account must contain an S3 bucket and a
DynamoDB table to support Terraform remote shared state, and the
"users" account must contain some IAM user accounts before the other
accounts can be bootstrapped.  Therefore, in addition to using the
programmatic credentials as described above, these two accounts must
use local state for the first apply.  Then the local state can be
migrated to the remote backend hosted in the "terraform" account and
future applies can proceed normally.

Note that step-by-step bootstrapping instructions are given in the
account-specific `README.md` files found in the account
subdirectories.

## Notes ##

Running `pre-commit` requires running `terraform init` in every
directory that contains Terraform code. In this repository, this
includes each account directory (e.g. `audit/`, `dns/`, `dynamic/`,
etc.), as well as `provisionaccount-role-tf-module` and every
directory under its `examples/` directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
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
