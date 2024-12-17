# ------------------------------------------------------------------------------
# Create the IAM role that allows write access to the assessment findings S3
# bucket (specified by var.assessment_findings_bucket_name).
# ------------------------------------------------------------------------------

resource "aws_iam_role" "assessment_findings_bucket_write" {
  # Use a count here to avoid an AWS error with the assume role policy when the
  # list of assessment account IDs is empty.
  count = length(local.assessment_account_ids) > 0 ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.assessment_account_assume_role_doc.json
  description        = var.assessment_findings_bucket_write_role_description
  name               = var.assessment_findings_bucket_write_role_name
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "assessment_findings_bucket_write" {
  # Use a count here to stay in sync with the count in the role resource above.
  count = length(local.assessment_account_ids) > 0 ? 1 : 0

  policy_arn = aws_iam_policy.assessment_findings_bucket_write.arn
  role       = aws_iam_role.assessment_findings_bucket_write[0].name
}
