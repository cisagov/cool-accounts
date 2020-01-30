# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to create
# all AWS resources in the terraform account.
# ------------------------------------------------------------------------------

# IAM policy document that allows sufficient permissions to create all
# AWS resources in the terraform account.
data "aws_iam_policy_document" "create_doc" {
  # Permissions necessary to create the state bucket
  statement {
    actions = [
      "s3:CreateBucket"
    ]
    resources = [
      aws_s3_bucket.state_bucket.arn
    ]
  }

  # Permissions necessary to create the state lock table
  statement {
    actions = [
      "dynamodb:CreateTable",
    ]
    resources = [
      "${aws_dynamodb_table.state_lock_table.arn}/*"
    ]
  }

  # Permissions necessary to create the IAM policies
  statement {
    actions = [
      "dynamodb:CreatePolicy",
    ]
    resources = [
      aws_iam_policy.backend_access_policy.arn,
      # Referencing the aws_iam_policy.create_policy resource defined
      # below creates a circular dependency, but we can construct what
      # the ARN looks like.
      "arn:aws:iam::*:policy/${var.create_role_name}"
    ]
  }

  # Permissions necessary to create the IAM roles
  statement {
    actions = [
      "dynamodb:CreateRole",
    ]
    resources = [
      aws_iam_role.backend_role.arn,
      aws_iam_role.create_role.arn,
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "create_policy" {
  description = var.create_role_description
  name        = var.create_role_name
  policy      = data.aws_iam_policy_document.create_doc.json
}
