# This is the "default" provider that is used to create resources
# inside the Audit account
provider "aws" {
  region = var.aws_region
  # Use this profile once the account has been bootstrapped.
  profile = "cool-audit-provisionaccount"
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL Audit account
  # from the AWS SSO page, to bootstrap the account.
  # profile = "cool-audit-account-admin"
}

# This is the "users" provider that is used to create resources inside
# the users account
provider "aws" {
  alias   = "users"
  region  = var.aws_region
  profile = "cool-users-provisionaccount"
}
