# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows
# administering KMS keys in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisionadministerkmskeys_policy_attachment" {
  policy_arn = aws_iam_policy.administerkmskeys_policy.arn
  role       = var.provisionaccount_role_name
}
