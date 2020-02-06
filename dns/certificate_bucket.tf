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
