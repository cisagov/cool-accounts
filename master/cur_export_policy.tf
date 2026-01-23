# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to create the
# resources needed for cost and usage report (CUR) data export (see
# cisagov/cool-master-cur).
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "cur_export_doc" {
  # Permissions necessary to manage S3 buckets
  statement {
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket*",
      "s3:Get*",
      "s3:ListBucket*",
      "s3:Put*",
    ]

    resources = ["*"]
  }
}

# The IAM policy
resource "aws_iam_policy" "cur_export_policy" {
  description = var.cur_export_policy_description
  name        = var.cur_export_policy_name
  policy      = data.aws_iam_policy_document.cur_export_doc.json
}
