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
      "arn:aws:s3:::${var.state_bucket_name}",
    ]
  }

  # Permissions necessary to create the state lock table
  statement {
    actions = [
      "dynamodb:CreateTable",
    ]
    resources = [
      "arn:aws:dynamodb:${var.aws_region}:${var.this_account_id}:table/${var.state_table_name}",
    ]
  }

  # Permissions necessary to create the IAM policies
  statement {
    actions = [
      "iam:CreatePolicy",
    ]
    resources = [
      "arn:aws:iam::${var.this_account_id}:policy/${var.backend_role_name}",
      "arn:aws:iam::${var.this_account_id}:policy/${var.create_role_name}",
    ]
  }

  # Permissions necessary to create the IAM roles
  statement {
    actions = [
      "iam:CreateRole",
    ]
    resources = [
      "arn:aws:iam::${var.this_account_id}:role/${var.backend_role_name}",
      "arn:aws:iam::${var.this_account_id}:role/${var.create_role_name}",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "create_policy" {
  description = var.create_role_description
  name        = var.create_role_name
  policy      = data.aws_iam_policy_document.create_doc.json
}
