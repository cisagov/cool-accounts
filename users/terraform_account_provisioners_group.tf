# An IAM group for users allowed to provision the Terraform account
resource "aws_iam_group" "terraform_account_provisioners" {
  name = var.terraform_account_provisioners_group_name
}
