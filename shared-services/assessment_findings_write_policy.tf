# ------------------------------------------------------------------------------
# Create the IAM policy that allows write access to the assessment findings S3
# bucket (specified by var.assessment_findings_bucket_arn).
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assessment_findings_bucket_write" {
  statement {
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${var.assessment_findings_bucket_arn}/${var.assessment_findings_bucket_object_name_pattern}",
    ]
  }
}

# The IAM policy for write access to the assessment findings bucket
resource "aws_iam_policy" "assessment_findings_bucket_write" {
  description = var.assessment_findings_bucket_write_role_description
  name        = var.assessment_findings_bucket_write_role_name
  policy      = data.aws_iam_policy_document.assessment_findings_bucket_write.json
}
