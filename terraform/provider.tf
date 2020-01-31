provider "aws" {
  region = var.aws_region
  # Use this role once the account has been bootstrapped.
  # assume_role {
  #   role_arn = "arn:aws:iam::${var.this_account_id}:role/${var.create_role_name}"
  # }
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL terraform account
  # from the AWS SSO page, to bootstrap the account.
  profile = "cool-terraform-account-admin"
}
