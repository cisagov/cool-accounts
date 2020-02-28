# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the Route 53 actions necessary to
# provision Delegation Sets in the DNS account
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionroute53_doc" {
  statement {
    actions = [
      "route53:CreateReusableDelegationSet",
      "route53:GetReusableDelegationSet",
      "route53:ListReusableDelegationSets"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "provisionroute53_policy" {
  description = var.provisionroute53_role_description
  name        = var.provisionroute53_role_name
  policy      = data.aws_iam_policy_document.provisionroute53_doc.json
}
