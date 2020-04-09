# ------------------------------------------------------------------------------
# Create an S3 bucket to store third-party files, such as installation
# packages that are not directly downloadable.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "third_party" {
  acl    = "private"
  bucket = format("%s-%s", var.third_party_bucket_name_prefix, lower(local.this_account_type))

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
