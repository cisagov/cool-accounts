# This is the "default" provider that is used to create resources
# inside the DNS account
provider "aws" {
  region = var.aws_region
  # Use this profile once the account has been bootstrapped.
  profile = "cool-dns-provisionaccount"
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL DNS account from
  # the AWS SSO page, to bootstrap the account.
  # profile = "cool-dns-account-admin"
}

# This is the "users" provider that is used to create resources inside
# the users account
provider "aws" {
  alias   = "users"
  region  = var.aws_region
  profile = "cool-users-provisionaccount"
}
