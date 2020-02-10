# This is the "default" provider that is used to create resources
# inside the Terraform account
provider "aws" {
  region = var.aws_region
  # Use this role once the terraform account has been bootstrapped.
  assume_role {
    role_arn = "arn:aws:iam::${var.this_account_id}:role/${var.provisionaccount_role_name}"
  }
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL Terraform account
  # from the AWS SSO page, to bootstrap the Terraform account.
  # profile = "cool-terraform-account-admin"
}

# This is the "users" provider that is used to create resources inside
# the users account
provider "aws" {
  alias  = "users"
  region = var.aws_region
  # Use this role once the terraform account has been bootstrapped.
  assume_role {
    role_arn = "arn:aws:iam::${var.users_account_id}:role/${var.provisionaccount_role_name}"
  }
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL Terraform account
  # from the AWS SSO page, to bootstrap the Terraform account.
  # profile = "cool-users-account-admin"
}
