# ------------------------------------------------------------------------------
# Create the S3 bucket where the Terraform state will be stored.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "state_bucket" {
  bucket = var.bucket_name
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.tags
  versioning {
    enabled = true
  }
}
