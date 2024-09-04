# ------------------------------------------------------------------------------
# Create the IAM role that allows write access to the S3 bucket where
# Lambda zip files are stored.  This is useful when a user wants to
# upload a new Lambda zip from the CLI.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "write_lambda_bucket_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_users_doc.json
  description        = var.write_lambda_bucket_role_description
  name               = var.write_lambda_bucket_role_name
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "write_lambda_bucket_policy_attachment" {
  policy_arn = aws_iam_policy.write_lambda_bucket_policy.arn
  role       = aws_iam_role.write_lambda_bucket_role.name
}
