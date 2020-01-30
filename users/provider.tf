provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = var.access_terraform_backend_role_arn
  }
}
