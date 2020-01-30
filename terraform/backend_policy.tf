# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient access to the S3 bucket
# and DynamoDB table to use them for a Terraform backend.
# ------------------------------------------------------------------------------

# IAM policy document that allows sufficient access to the state
# bucket and state locking table to use those resources as a Terraform
# backend.
data "aws_iam_policy_document" "state_access_doc" {
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.the_bucket.arn
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.the_bucket.arn}/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      "${aws_dynamodb_table.the_table.arn}/*"
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "state_access_policy" {
  description = "Allows sufficient access to the state bucket and state locking table to use those resources as a Terraform backend."
  name        = "AccessTerraformBackend"
  policy      = data.aws_iam_policy_document.state_access_doc.json
  tags        = var.tags
}
