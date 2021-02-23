# ------------------------------------------------------------------------------
# Create the IAM policy that gives the ability to create IAM roles
# that can read objects in the third-party file storage bucket
# in the Images account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionthirdpartybucketreadroles" {
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
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription",
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.images.account_id}:role/ThirdPartyBucketRead-*"
    ]
  }

  statement {
    actions = [
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.images.account_id}:policy/ThirdPartyBucketRead-*"
    ]
  }
}

resource "aws_iam_policy" "provisionthirdpartybucketreadroles" {
  description = var.provisionthirdpartybucketreadroles_role_description
  name        = var.provisionthirdpartybucketreadroles_role_name
  policy      = data.aws_iam_policy_document.provisionthirdpartybucketreadroles.json
}
