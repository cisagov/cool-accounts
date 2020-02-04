# An IAM group for users allowed to provision the users account
resource "aws_iam_group" "users_account_provisioners" {
  name = var.users_account_provisioners_group_name
}
