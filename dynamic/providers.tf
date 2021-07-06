# This is the "default" provider that is used to create resources
# inside the dynamic account
provider "aws" {
  default_tags {
    tags = var.tags
  }
  # Use this profile once the account has been bootstrapped.
  profile = "cool-${var.dynamic_account_name}-provisionaccount"
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the dynamic account from
  # the COOL AWS SSO page, to bootstrap the account.
  # profile = "cool-${var.dynamic_account_name}-account-admin"
  region = var.aws_region
}
