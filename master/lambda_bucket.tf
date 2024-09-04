# ------------------------------------------------------------------------------
# Provision the S3 bucket where Lambda zip files will be stored.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "lambda_bucket" {
  # We can't perform this action until our policy is in place.
  depends_on = [
    aws_iam_role_policy_attachment.s3_full_access,
  ]

  bucket = var.lambda_bucket_name

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lambda_bucket" {
  bucket = aws_s3_bucket.lambda_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# This blocks ANY public access to the bucket or the objects it
# contains, even if misconfigured to allow public access.
resource "aws_s3_bucket_public_access_block" "lambda_bucket" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.lambda_bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# A bucket policy that allows the organization to read the bucket.
data "aws_iam_policy_document" "allow_bucket_read_access_within_org" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    condition {
      test = "StringEquals"
      values = [
        data.aws_organizations_organization.cool.id,
      ]
      variable = "aws:PrincipalOrgId"
    }

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_s3_bucket.lambda_bucket.arn,
      "${aws_s3_bucket.lambda_bucket.arn}/*",
    ]
  }
}

# Attach the bucket policy
resource "aws_s3_bucket_policy" "allow_bucket_read_access_within_org" {
  bucket = aws_s3_bucket.lambda_bucket.id
  policy = data.aws_iam_policy_document.allow_bucket_read_access_within_org.json
}
