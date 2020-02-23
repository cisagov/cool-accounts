# ------------------------------------------------------------------------------
# Create the IAM role that allows read-only access to all AWS
# Organizations information.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "organizationsreadonly_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.organizationsreadonly_role_description
  name               = var.organizationsreadonly_role_name
  tags               = var.tags
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "organizationsreadonly_policy_attachment" {
  policy_arn = aws_iam_policy.organizationsreadonly_policy.arn
  role       = aws_iam_role.organizationsreadonly_role.name
}
