provider "aws" {
  region = var.aws_region
  # Use this role once the account has been bootstrapped.
  # assume_role {
  #   role_arn = var.access_terraform_backend_role_arn
  # }
  # Use the profile below, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL "users" account
  # from the AWS SSO page, to bootstrap the account.
  # Comment out the profile below after this account has been bootstrapped.
  profile = "cool-users-account-admin"
}
