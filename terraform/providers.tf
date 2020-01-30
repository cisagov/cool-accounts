provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = var.create_role_arn
  }
}
