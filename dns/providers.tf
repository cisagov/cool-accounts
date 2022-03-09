# This is the "default" provider that is used to create resources
# inside the DNS account
provider "aws" {
  default_tags {
    tags = var.tags
  }
  # Use this profile once the account has been bootstrapped.
  profile = "cool-dns-provisionaccount"
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL DNS account from
  # the AWS SSO page, to bootstrap the account.
  # profile = "cool-dns-account-admin"
  region = var.aws_region
}

# Read-only AWS Organizations provider
provider "aws" {
  alias = "organizationsreadonly"
  default_tags {
    tags = var.tags
  }
  profile = "cool-master-organizationsreadonly"
  region  = var.aws_region
}
