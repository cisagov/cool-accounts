# ------------------------------------------------------------------------------
# Create the primary reusable delegation set.
# It is imperative that this delgation set never be deleted.
# ------------------------------------------------------------------------------

resource "aws_route53_delegation_set" "primary" {
  # We can't perform this action until our policy is in place.
  depends_on = [
    aws_iam_role_policy_attachment.provisionroute53_policy_attachment,
    aws_iam_policy.provisionroute53_policy
  ]

  lifecycle {
    prevent_destroy = true
  }
  reference_name = "primary"
}
