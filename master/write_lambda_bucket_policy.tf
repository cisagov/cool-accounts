# ------------------------------------------------------------------------------
# Create the IAM policy that allows write access to the S3 bucket
# where Lambda deployment packages are stored.  This is useful when a
# user wants to upload a new Lambda deployment package from the CLI.
# ------------------------------------------------------------------------------

# IAM policy document that allows write access to the S3 bucket where
# Lambda deployment packages are to be stored.
data "aws_iam_policy_document" "write_lambda_bucket_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.lambda_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:*Object",
    ]
    resources = [
      "${aws_s3_bucket.lambda_bucket.arn}/*",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "write_lambda_bucket_policy" {
  description = var.write_lambda_bucket_role_description
  name        = var.write_lambda_bucket_role_name
  policy      = data.aws_iam_policy_document.write_lambda_bucket_doc.json
}
