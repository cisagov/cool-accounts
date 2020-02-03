# IAM assume role policy document that allows assumption of the IAM
# role that can access the terraform remote backend
data "aws_iam_policy_document" "assume_access_terraform_backend_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${var.terraform_account_id}:role/AccessTerraformBackend"
    ]
  }
}

resource "aws_iam_policy" "assume_access_terraform_backend_role" {
  description = var.assume_access_terraform_backend_policy_description
  name        = var.assume_access_terraform_backend_policy_name
  policy      = data.aws_iam_policy_document.assume_access_terraform_backend_doc.json
}

# Attach the policy to the terraform backend users group
resource "aws_iam_group_policy_attachment" "access_terraform_backend" {
  group      = aws_iam_group.terraform_backend_users.name
  policy_arn = aws_iam_policy.assume_access_terraform_backend_role.arn
}
