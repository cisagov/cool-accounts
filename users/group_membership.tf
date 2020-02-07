# Put our admin IAM users in the Terraform backend access and user
# account provisioners groups.
resource "aws_iam_user_group_membership" "admin_user" {
  count = length(var.admin_usernames)

  user = aws_iam_user.admin_user[count.index].name

  groups = [
    aws_iam_group.terraform_backend_users.name,
    aws_iam_group.users_account_provisioners.name
  ]
}
