# Comment out the contents of this file when bootstrapping this
# account.
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    # Use this profile once both the Terraform and Users accounts have been
    # bootstrapped.
    profile = "cool-terraform-backend"
    # Use this profile, defined using programmatic credentials for
    # AWSAdministratorAccess as obtained for the COOL Terraform account
    # from the AWS SSO page, to bootstrap the Users account.
    # profile = "cool-terraform-account-admin"
    region = "us-east-1"
    key    = "cool-accounts/users.tfstate"
  }
}
