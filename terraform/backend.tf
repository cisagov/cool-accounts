# Comment out the contents of this file when bootstrapping this
# account.
terraform {
  backend "s3" {
    # Use a partial configuration to avoid hardcoding the bucket name. This
    # allows the bucket name to be set on a per-environment basis via the
    # -backend-config command line option or other methods.  For details, see:
    # https://developer.hashicorp.com/terraform/language/backend#partial-configuration
    bucket         = ""
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    key            = "cool-accounts/terraform.tfstate"
    # Use this profile once both the Terraform and Users accounts have been
    # bootstrapped.
    profile = "cool-terraform-backend"
    # Use this profile, defined using programmatic credentials for
    # AWSAdministratorAccess as obtained for the COOL Terraform account
    # from the AWS SSO page, to bootstrap the Terraform account.
    # profile = "cool-terraform-account-admin"
    region = "us-east-1"
  }
}
