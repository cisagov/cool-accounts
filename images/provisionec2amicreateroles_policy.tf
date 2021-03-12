# ------------------------------------------------------------------------------
# Create the IAM policy that gives the ability to create IAM roles
# that can create AMIs in the Images account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionec2amicreateroles_doc" {
  statement {
    actions = [
      "iam:AttachRolePolicy",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:ListRolePolicies",
      "iam:PutRolePolicy",
      "iam:TagRole",
      "iam:UpdateRole"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.images.account_id}:role/EC2AMICreate-*"
    ]
  }

  statement {
    actions = [
      "iam:CreatePolicy",
      "iam:DeletePolicy",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.images.account_id}:policy/EC2AMICreate-*"
    ]
  }
}

resource "aws_iam_policy" "provisionec2amicreateroles_policy" {
  description = var.provisionec2amicreateroles_role_description
  name        = var.provisionec2amicreateroles_role_name
  policy      = data.aws_iam_policy_document.provisionec2amicreateroles_doc.json
}
