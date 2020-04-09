# ------------------------------------------------------------------------------
# Create the IAM policy that allows read access to objects in the
# third-party file storage bucket in the Images account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "thirdpartybucketread_doc" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.third_party.arn
    ]
  }

  statement {
    actions = [
      "s3:HeadBucket",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "${aws_s3_bucket.third_party.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "thirdpartybucketread_policy" {
  description = var.thirdpartybucketread_role_description
  name        = var.thirdpartybucketread_role_name
  policy      = data.aws_iam_policy_document.thirdpartybucketread_doc.json
}
