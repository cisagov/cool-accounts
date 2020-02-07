# ------------------------------------------------------------------------------
# Attach IAM policy that allows sufficient permissions to provision
# the S3 bucket and DynamoDB table resources in the terraform account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisionaccount_policy_attachment" {
  policy_arn = aws_iam_policy.provisionaccount_policy.arn
  role       = module.provisionaccount.provisionaccount_role_name
}
