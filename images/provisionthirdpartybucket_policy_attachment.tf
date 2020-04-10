# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows
# provisioning of the third-party file storage S3 bucket in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisionthirdpartybucket" {
  policy_arn = aws_iam_policy.provisionthirdpartybucket.arn
  role       = var.provisionaccount_role_name
}
