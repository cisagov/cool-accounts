terraform {
  backend "s3" {
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    key            = "cool-accounts/shared_services.tfstate"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
  }
}
