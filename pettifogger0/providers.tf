# This is the "default" provider that is used to create resources
# inside the new account
provider "aws" {
  region = var.aws_region
  # Use this role once the account has been bootstrapped.
  assume_role {
    role_arn = "arn:aws:iam::${var.this_account_id}:role/ProvisionAccount"
  }
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL Images account
  # from the AWS SSO page, to bootstrap the account.
  # profile = "cool-pettifogger0-account-admin"
}

# This is the "users" provider that is used to create resources inside
# the users account
provider "aws" {
  alias  = "users"
  region = var.aws_region
  # Use this role once the account has been bootstrapped.
  assume_role {
    role_arn = "arn:aws:iam::${var.users_account_id}:role/ProvisionAccount"
  }
}
