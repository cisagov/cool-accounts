# ------------------------------------------------------------------------------
# Create the IAM role that is allowed to itself create IAM roles that
# can create AMIs in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "provisionec2amicreateroles_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.provisionec2amicreateroles_role_description
  name               = var.provisionec2amicreateroles_role_name
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "provisionec2amicreateroles_policy_attachment" {
  policy_arn = aws_iam_policy.provisionec2amicreateroles_policy.arn
  role       = aws_iam_role.provisionec2amicreateroles_role.name
}
