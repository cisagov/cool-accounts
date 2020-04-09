# ------------------------------------------------------------------------------
# Create the IAM role that allows read access to objects in the
# third-party file storage bucket in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "thirdpartybucketread_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.thirdpartybucketread_role_description
  name               = var.thirdpartybucketread_role_name
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "thirdpartybucketread_policy_attachment" {
  policy_arn = aws_iam_policy.thirdpartybucketread_policy.arn
  role       = aws_iam_role.thirdpartybucketread_role.name
}
