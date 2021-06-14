# The god-like users being created
resource "aws_iam_user" "gods" {
  for_each = toset(var.godlike_usernames)

  name = each.key
}

# Attach the self-administration (no MFA required) policy to each godlike user
resource "aws_iam_user_policy_attachment" "self_managed_creds_without_mfa" {
  for_each = toset(var.godlike_usernames)

  user       = each.key
  policy_arn = aws_iam_policy.self_managed_creds_without_mfa.arn
}
