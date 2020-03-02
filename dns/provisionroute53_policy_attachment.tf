# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows
# provisioning Route 53 in the DNS account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisionroute53_policy_attachment" {
  policy_arn = aws_iam_policy.provisionroute53_policy.arn
  role       = var.provisionaccount_role_name
}
