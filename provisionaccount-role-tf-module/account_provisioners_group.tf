# An IAM group for users allowed to provision the new account
resource "aws_iam_group" "account_provisioners" {
  provider = aws.users

  name = var.account_provisioners_group_name
}

# Put our admin IAM users in the account provisioners group for the
# new account.
resource "aws_iam_group_membership" "account_provisioners" {
  provider = aws.users

  group = aws_iam_group.account_provisioners.name
  name  = var.account_provisioners_group_membership_name
  users = var.admin_usernames
}
