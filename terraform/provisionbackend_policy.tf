# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to
# provision the S3 bucket and DynamoDB table resources for the
# Terraform backend in the terraform account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionbackend_doc" {
  # Permissions necessary to manipulate the state bucket
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.state_bucket_name}",
    ]
  }

  # Permissions necessary to manipulate the state lock table
  statement {
    actions = [
      "dynamodb:*",
    ]
    resources = [
      "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.terraform.account_id}:table/${var.state_table_name}",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "provisionbackend_policy" {
  description = var.provisionbackend_policy_description
  name        = var.provisionbackend_policy_name
  policy      = data.aws_iam_policy_document.provisionbackend_doc.json
}
