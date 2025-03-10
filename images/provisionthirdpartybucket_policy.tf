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

  # These are the permissions required to add the SSM Parameter Store
  # parameter containing the name of the third-party bucket.
  statement {
    actions = [
      "ssm:AddTagsToResource",
      "ssm:DeleteParameter",
      "ssm:DeleteParameters",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
      "ssm:ListTagsForResource",
      "ssm:PutParameter",
      "ssm:RemoveTagsFromResource",
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.images.account_id}:parameter/${var.third_party_bucket_parameter_name}",
    ]
  }
  statement {
    actions = [
      "ssm:DescribeParameters",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "provisionthirdpartybucket" {
  description = var.provisionthirdpartybucket_policy_description
  name        = var.provisionthirdpartybucket_policy_name
  policy      = data.aws_iam_policy_document.provisionthirdpartybucket.json
}
