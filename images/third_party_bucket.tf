# ------------------------------------------------------------------------------
# Create an S3 bucket to store third-party files, such as installation
# packages that are not directly downloadable.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "third_party" {
  acl    = "private"
  bucket = local.third_party_bucket_name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(var.tags,
    {
      "GitHub_Secret_Name"             = "THIRD_PARTY_BUCKET_${upper(local.this_account_type)}",
      "GitHub_Secret_Terraform_Lookup" = "id"
    }
  )

  versioning {
    enabled = true
  }
}
