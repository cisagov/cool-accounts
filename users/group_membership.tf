# Put our admin IAM users in the Terraform backend access and user
# account provisioners groups.
resource "aws_iam_user_group_membership" "admin_user" {
  for_each = var.admin_usernames

  user = aws_iam_user.admin_user[each.key].name

  groups = [
    aws_iam_group.users_account_provisioners.name
  ]
}
