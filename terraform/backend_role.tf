# ------------------------------------------------------------------------------
# Create the IAM role that allows sufficient access to the S3 bucket
# and DynamoDB table to use them for a Terraform backend.
# ------------------------------------------------------------------------------

# IAM assume role policy document for the IAM role being created
data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    dynamic "principals" {
      for_each = var.trusted_account_ids
      iterator = ids

      content {
        type = "AWS"
        identifiers = [
          "arn:aws:iam::${ids.value}:root"
        ]
      }
    }
  }
}

# The IAM role
resource "aws_iam_role" "the_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = "Allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  name               = "UseTerraformBackendResources"
  tags               = var.tags
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "state_access_policy_attachment" {
  policy = data.aws_iam_policy_document.state_access_doc.json
  role   = aws_iam_role.the_role.id
}
