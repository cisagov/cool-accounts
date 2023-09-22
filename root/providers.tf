# This is the "default" provider that is used to create resources
# inside the Root account
provider "aws" {
  default_tags {
    tags = var.tags
  }
  # Use this profile once the account has been bootstrapped.
  profile = "cool-root-provisionaccount"
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL Root account
  # from the AWS SSO page, to bootstrap the account.
  # profile = "cool-root-account-admin"
  region = var.aws_region
}
