# This is the "default" provider that is used to create resources
# inside the Terraform account
provider "aws" {
  region = var.aws_region
  # Use this profile once the terraform account has been bootstrapped.
  profile = "cool-terraform-provisionaccount"
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
  # Use this role once the users account has been bootstrapped.
  profile = "cool-users-provisionaccount"
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL Terraform account
  # from the AWS SSO page, to bootstrap the Users account.
  # profile = "cool-users-account-admin"
}
