# ------------------------------------------------------------------------------
# Create the IAM role that allows all of the KMS actions necessary to
# administer all KMS keys in the Images account.
#
# NOTE: There may be a future need to create a role that only allows
# administration of the KMS key used to encrypt AMIs, but at this time
# such a role is not required.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "administerkmskeys_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.administerkmskeys_role_description
  name               = var.administerkmskeys_role_name
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "administerkmskeys_policy_attachment" {
  policy_arn = aws_iam_policy.administerkmskeys_policy.arn
  role       = aws_iam_role.administerkmskeys_role.name
}
