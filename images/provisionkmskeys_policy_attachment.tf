# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows
# provisioning KMS keys in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisionkmskeys_policy_attachment" {
  policy_arn = aws_iam_policy.provisionkmskeys_policy.arn
  role       = var.provisionaccount_role_name
}
