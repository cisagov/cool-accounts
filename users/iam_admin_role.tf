# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient permissions to create all
# AWS resources in the users account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "iam_admin_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_iam_admin_role_doc.json
  description        = var.iam_admin_role_description
  name               = var.iam_admin_role_name
  tags               = var.tags
}

# Attach IAMFullAccess policy to the role
resource "aws_iam_role_policy_attachment" "iamfullaccess_policy_attachment" {
  policy_arn = "arn:aws:iam::${var.this_account_id}:policy/IAMFullAccess"
  role       = aws_iam_role.iam_admin_role.name
}
