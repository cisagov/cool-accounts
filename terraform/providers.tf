# This is the "default" provider that is used to create resources
# inside the Terraform account
provider "aws" {
  default_tags {
    tags = var.tags
  }
  # Use this profile once the terraform account has been bootstrapped.
  profile = "cool-terraform-provisionaccount"
  # Use this profile, defined using programmatic credentials for
  # AWSAdministratorAccess as obtained for the COOL Terraform account
  # from the AWS SSO page, to bootstrap the Terraform account.
  # profile = "cool-terraform-account-admin"
  region = var.aws_region
}
