# An IAM group for users allowed to be IAM administrators
resource "aws_iam_group" "iam_admins" {
  name = var.iam_admins_group
}

# Put our IAM users in the group to make them IAM administrators
resource "aws_iam_user_group_membership" "user" {
  count = length(var.usernames)

  user = aws_iam_user.user[count.index].name

  groups = [
    aws_iam_group.usernames.name,
  ]
}
