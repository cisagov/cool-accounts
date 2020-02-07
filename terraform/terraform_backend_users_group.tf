# An IAM group for users allowed to access terraform remote backend.
resource "aws_iam_group" "terraform_backend_users" {
  provider = aws.users

  name = var.terraform_backend_users_group_name
}

# Put our admin IAM users in the terraform backend users group
resource "aws_iam_group_membership" "terraform_backend_users" {
  provider = aws.users

  group = aws_iam_group.terraform_backend_users.name
  name  = var.terraform_backend_users_group_membership_name
  users = var.admin_usernames
}
