# An IAM group for users allowed to provision the Shared Services
# account
resource "aws_iam_group" "sharedservices_account_provisioners" {
  name = var.sharedservices_account_provisioners_group_name
}
