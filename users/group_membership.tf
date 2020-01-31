# Put our IAM users in the terraform backend access and IAM admin groups
resource "aws_iam_user_group_membership" "user" {
  count = length(var.usernames)

  user = aws_iam_user.user[count.index].name

  groups = [
    aws_iam_group.terraform_backend_users.name,
    aws_iam_group.iam_admins.name
  ]
}
