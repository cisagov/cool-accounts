# ------------------------------------------------------------------------------
# Create the IAM policy that allows read-only access to the S3 bucket
# where Terraform remote state is stored.  This is useful for cases when
# the remote state data is needed, but full access to the backend is not.
# ------------------------------------------------------------------------------

# IAM policy document that allows read-only access to the
# Terraform state bucket.
data "aws_iam_policy_document" "read_terraform_state_doc" {
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
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.state_bucket.arn}/*",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "read_terraform_state_policy" {
  description = var.read_terraform_state_role_description
  name        = var.read_terraform_state_role_name
  policy      = data.aws_iam_policy_document.read_terraform_state_doc.json
}
