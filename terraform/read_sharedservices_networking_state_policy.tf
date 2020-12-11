# ------------------------------------------------------------------------------
# Create the IAM policy that allows read-only access to the Shared Services
# networking state in the S3 bucket where Terraform remote state is stored.
# This is useful for cases when the Shared Services networking remote state
# data is needed, but read-only access to other Terraform states in the bucket
# is not.
# ------------------------------------------------------------------------------

# IAM policy document that allows read-only access to the Shared Services
# networking state in the Terraform state bucket.
data "aws_iam_policy_document" "read_sharedservices_networking_terraform_state_doc" {
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
      "${aws_s3_bucket.state_bucket.arn}/env:/*/cool-sharedservices-networking/*",
    ]
  }
}

# The IAM policy for Shared Services networking Terraform state access
resource "aws_iam_policy" "read_sharedservices_networking_terraform_state_policy" {
  description = var.read_sharedservices_networking_terraform_state_policy_description
  name        = var.read_sharedservices_networking_terraform_state_policy_name
  policy      = data.aws_iam_policy_document.read_sharedservices_networking_terraform_state_doc.json
}
