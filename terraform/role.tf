# ------------------------------------------------------------------------------
# Create the S3 bucket where the Terraform state will be stored.
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
  name               = "TerraformStateAccess"
  description        = "Allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
}

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

# The IAM policy for our role
resource "aws_iam_role_policy" "state_access_policy" {
  role   = aws_iam_role.the_role.id
  policy = data.aws_iam_policy_document.state_access_doc.json
}
