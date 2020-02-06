# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to
# provision all AWS resources in the terraform account.
# ------------------------------------------------------------------------------

# We will also attach the IAMFullAccess policy to the role that uses
# this policy, so it will have all necessary permissions to provision
# all AWS resources in the terraform account.
data "aws_iam_policy_document" "provisionaccount_doc" {
  # Permissions necessary to manipulate the certificate bucket
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.certificate_bucket_name}",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "provisionaccount_policy" {
  description = var.provisionaccount_role_description
  name        = var.provisionaccount_role_name
  policy      = data.aws_iam_policy_document.provisionaccount_doc.json
}
