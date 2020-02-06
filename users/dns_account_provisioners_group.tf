# An IAM group for users allowed to provision the DNS account
resource "aws_iam_group" "dns_account_provisioners" {
  name = var.dns_account_provisioners_group_name
}
