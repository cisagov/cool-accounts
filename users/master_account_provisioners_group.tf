# An IAM group for users allowed to provision the Master account
resource "aws_iam_group" "master_account_provisioners" {
  name = var.master_account_provisioners_group_name
}
