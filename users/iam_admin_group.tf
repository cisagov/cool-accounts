# An IAM group for users allowed to be IAM administrators
resource "aws_iam_group" "iam_admins" {
  name = var.iam_admins_group
}
