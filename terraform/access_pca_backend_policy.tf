# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient access to PCA-related S3 and
# DynamoDB resources to use them for a Terraform backend.  Note that this
# policy does NOT allow access to non-PCA S3 and DynamoDB resources.
# ------------------------------------------------------------------------------

# IAM policy document that allows sufficient access to the state
# bucket and state locking table to use those resources as a Terraform
# backend for PCA projects.
data "aws_iam_policy_document" "access_pca_terraform_backend_access_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.state_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
    ]
    # Any workspace of any project in var.pca_terraform_projects
    resources = [for tf_project in var.pca_terraform_projects : format("%s/env:/*/%s/*", aws_s3_bucket.state_bucket.arn, tf_project)]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    resources = [
      "${aws_dynamodb_table.state_lock_table.arn}",
    ]
  }
}

# The IAM policy for PCA Terraform access
resource "aws_iam_policy" "access_pca_terraform_backend_access_policy" {
  description = var.access_pca_terraform_backend_role_description
  name        = var.access_pca_terraform_backend_role_name
  policy      = data.aws_iam_policy_document.access_pca_terraform_backend_access_doc.json
}
