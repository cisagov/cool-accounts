# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows
# provisioning of the SSM Document resource required in this account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisionssmdocument_policy_attachment" {
  policy_arn = aws_iam_policy.provisionssmdocument_policy.arn
  role       = module.provisionaccount.provisionaccount_role.name
}
