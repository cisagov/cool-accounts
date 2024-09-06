# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to read from the bucket containing the COOL lambda deployments.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "read_lambda_bucket_policy_doc" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.lambda_bucket_name}",
      "arn:aws:s3:::${var.lambda_bucket_name}/*"
    ]
  }
}

resource "aws_iam_policy" "read_lambda_bucket_policy" {
  description = var.read_lambda_bucket_policy_description
  name        = var.read_lambda_bucket_policy_name
  policy      = data.aws_iam_policy_document.read_lambda_bucket_policy_doc.json
}
