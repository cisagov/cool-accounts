# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the S3 actions necessary to
# provision the third-party file storage S3 bucket in the Images account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionthirdpartybucket" {
  statement {
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket*",
      "s3:Get*",
      "s3:ListBucket*",
      "s3:Put*",
    ]

    resources = [
      "arn:aws:s3:::${local.third_party_bucket_name}"
    ]
  }

  statement {
    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "provisionthirdpartybucket" {
  description = var.provisionthirdpartybucket_policy_description
  name        = var.provisionthirdpartybucket_policy_name
  policy      = data.aws_iam_policy_document.provisionthirdpartybucket.json
}
