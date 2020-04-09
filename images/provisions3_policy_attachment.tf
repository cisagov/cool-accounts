# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows
# provisioning of S3 buckets in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisions3_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = var.provisionaccount_role_name
}
