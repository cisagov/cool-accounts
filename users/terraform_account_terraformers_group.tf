# An IAM group for users allowed to be Terraform account terraformers
resource "aws_iam_group" "terraform_account_terraformers" {
  name = var.terraform_account_terraformers_group_name
}
