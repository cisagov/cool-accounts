# An IAM group for users allowed to access terraform remote backend.
resource "aws_iam_group" "terraform_backend_users" {
  name = var.terraform_backend_users_group
}
