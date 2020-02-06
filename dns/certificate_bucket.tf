# ------------------------------------------------------------------------------
# Create the S3 bucket where the Certboto certificates will be stored.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "certificate_bucket" {
  bucket = var.certificate_bucket_name
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.tags
}

# This blocks ANY public access to the bucket or the objects it
# contains, even if misconfigured to allow public access.
resource "aws_s3_bucket_public_access_block" "certificate_bucket" {
  bucket = aws_s3_bucket.certificate_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
