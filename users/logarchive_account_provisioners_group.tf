# An IAM group for users allowed to provision the Log Archive account
resource "aws_iam_group" "logarchive_account_provisioners" {
  name = var.logarchive_account_provisioners_group_name
}
