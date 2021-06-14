# ------------------------------------------------------------------------------
# Create the IAM role that is allowed to itself create IAM roles that can
# read objects in the third-party file storage bucket in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "provisionthirdpartybucketreadroles" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.provisionthirdpartybucketreadroles_role_description
  name               = var.provisionthirdpartybucketreadroles_role_name
}

resource "aws_iam_role_policy_attachment" "provisionthirdpartybucketreadroles" {
  policy_arn = aws_iam_policy.provisionthirdpartybucketreadroles.arn
  role       = aws_iam_role.provisionthirdpartybucketreadroles.name
}
