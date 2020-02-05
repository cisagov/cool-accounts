# Comment out the contents of this file when bootstrapping this
# account.
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    # Use this profile once the account has been bootstrapped.
    profile = "cool-terraform-backend"
    # Use the profile below, defined using programmatic credentials
    # for AWSAdministratorAccess as obtained for the COOL "users"
    # account from the AWS SSO page, to bootstrap the account.
    # Comment out this profile below after this account has been
    # bootstrapped.
    # profile = "cool-terraform-account-admin"
    region = "us-east-1"
    key    = "cool-accounts/users.tfstate"
  }
}
