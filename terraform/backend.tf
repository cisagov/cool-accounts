# Comment out the contents of this file when bootstrapping this
# account.
# terraform {
#   backend "s3" {
#     encrypt        = true
#     bucket         = "cisa-cool-terraform-state"
#     dynamodb_table = "terraform-state-lock"
#     profile        = "terraform-role"
#     region         = "us-east-1"
#     key            = "cool-accounts/terraform.tfstate"
#   }
# }
