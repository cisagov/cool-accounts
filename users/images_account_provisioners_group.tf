# An IAM group for users allowed to provision the Images account
resource "aws_iam_group" "images_account_provisioners" {
  name = var.images_account_provisioners_group_name
}
