# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows
# provisioning of VPCs in the Images account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisionvpcs_policy_attachment" {
  policy_arn = aws_iam_policy.provisionvpcs_policy.arn
  role       = var.provisionaccount_role_name
}
