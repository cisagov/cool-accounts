# Put our admin IAM users in the Terraform backend access, IAM admin, and
# Terraform account provisioners groups.
resource "aws_iam_user_group_membership" "admin_user" {
  for_each = var.admin_usernames

  user = aws_iam_user.admin_user[each.key].name

  groups = [
    aws_iam_group.sharedservices_account_provisioners.name,
    aws_iam_group.terraform_account_provisioners.name,
    aws_iam_group.terraform_backend_users.name,
    aws_iam_group.users_account_provisioners.name
  ]
}
