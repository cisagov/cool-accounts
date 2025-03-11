# ------------------------------------------------------------------------------
# Create an S3 bucket to store third-party files, such as installation
# packages that are not directly downloadable.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "third_party" {
  bucket = local.third_party_bucket_name

  lifecycle {
    prevent_destroy = true
  }
}

# Ensure the S3 bucket is encrypted
resource "aws_s3_bucket_server_side_encryption_configuration" "third_party" {
  bucket = aws_s3_bucket.third_party.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# This blocks ANY public access to the bucket or the objects it
# contains, even if misconfigured to allow public access.
resource "aws_s3_bucket_public_access_block" "third_party" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.third_party.id
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning on the bucket.
resource "aws_s3_bucket_versioning" "third_party" {
  bucket = aws_s3_bucket.third_party.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Any objects placed into this bucket should be owned by the bucket
# owner. This ensures that even if objects are added by a different
# account, the bucket-owning account retains full control over the
# objects stored in this bucket.
resource "aws_s3_bucket_ownership_controls" "third_party" {
  bucket = aws_s3_bucket.third_party.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Create an SSM Parameter Store parameter containing the name of the
# third-party bucket.
resource "aws_ssm_parameter" "third_party_bucket_name" {
  description = "The name of the S3 bucket where third-party files are stored."
  name        = var.third_party_bucket_parameter_name
  type        = "SecureString"
  value       = aws_s3_bucket.third_party.bucket
}
