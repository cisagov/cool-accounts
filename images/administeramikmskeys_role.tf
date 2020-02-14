# ------------------------------------------------------------------------------
# Create the IAM role that allows all of the KMS actions necessary to
# administer KMS keys for AMIs in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "administeramikmskeys_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.administeramikmskeys_role_description
  name               = var.administeramikmskeys_role_name
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "administeramikmskeys_policy_attachment" {
  policy_arn = aws_iam_policy.administeramikmskeys_policy.arn
  role       = aws_iam_role.administeramikmskeys_role.name
}
