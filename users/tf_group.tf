# An IAM group for users allowed to access terraform remote backend.
resource "aws_iam_group" "terraform_backend_users" {
  name = var.terraform_backend_users_group
}

# Put our IAM users in the group to allow them to access the terraform backend
resource "aws_iam_user_group_membership" "user" {
  count = length(var.terraform_backend_users)

  user = aws_iam_user.user[count.index].name

  groups = [
    aws_iam_group.terraform_backend_users.name,
  ]
}
