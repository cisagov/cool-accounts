provider "aws" {
  default_tags {
    tags = var.tags
  }
  # Use this profile once the account has been bootstrapped.
  profile = "cool-users-provisionaccount"
  # Use the profile below, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL "users" account
  # from the AWS SSO page, to bootstrap the account.
  # Comment out the profile below after this account has been bootstrapped.
  # profile = "cool-users-account-admin"
  region = var.aws_region
}
