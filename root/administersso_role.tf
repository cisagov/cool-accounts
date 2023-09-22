# ------------------------------------------------------------------------------
# Create the IAM role that allows all permissions necessary to administer
# the Single Sign-On (SSO) resources required in this account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "administersso_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_users_doc.json
  description        = var.administersso_role_description
  name               = var.administersso_role_name
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "administersso_policy_attachment" {
  policy_arn = aws_iam_policy.administersso_policy.arn
  role       = aws_iam_role.administersso_role.name
}
