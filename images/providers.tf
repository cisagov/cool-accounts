# This is the "default" provider that is used to create resources
# inside the Images account
provider "aws" {
  default_tags {
    tags = var.tags
  }
  # Use this profile once the account has been bootstrapped.
  profile = "cool-images-provisionaccount"
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL Images account
  # from the AWS SSO page, to bootstrap the account.
  # profile = "cool-images-account-admin"
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
