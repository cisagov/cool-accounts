# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to create
# all AWS resources in the terraform account.
# ------------------------------------------------------------------------------

# IAM policy document that allows sufficient permissions to create all
# non-IAM AWS resources in the terraform account.
#
# We will also attach the IAMFullAccess policy to the role that uses
# this policy, so it will have all necessary permissions to create all
# AWS resources in the terraform account.
data "aws_iam_policy_document" "create_doc" {
  # Permissions necessary to manipulate the state bucket
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.state_bucket_name}",
    ]
  }

  # Permissions necessary to create and manipulate the state lock table
  statement {
    actions = [
      "dynamodb:*",
    ]
    resources = [
      "arn:aws:dynamodb:${var.aws_region}:${var.this_account_id}:table/${var.state_table_name}",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "create_policy" {
  description = var.create_role_description
  name        = var.create_role_name
  policy      = data.aws_iam_policy_document.create_doc.json
}
