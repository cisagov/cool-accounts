# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient permissions to provision
# all AWS resources in the terraform account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "provision_account_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.provision_account_role_description
  name               = var.provision_account_role_name
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "iamfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  role       = aws_iam_role.provision_account_role.name
}
