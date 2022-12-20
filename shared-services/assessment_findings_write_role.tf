# ------------------------------------------------------------------------------
# Create the IAM role that allows write access to the assessment findings S3
# bucket (specified by var.assessment_findings_bucket_arn).
# ------------------------------------------------------------------------------

resource "aws_iam_role" "assessment_findings_bucket_write" {
  assume_role_policy = data.aws_iam_policy_document.asseessment_account_assume_role_doc.json
  description        = var.assessment_findings_bucket_write_role_description
  name               = var.assessment_findings_bucket_write_role_name
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "assessment_findings_bucket_write" {
  policy_arn = aws_iam_policy.assessment_findings_bucket_write.arn
  role       = aws_iam_role.assessment_findings_bucket_write.name
}
