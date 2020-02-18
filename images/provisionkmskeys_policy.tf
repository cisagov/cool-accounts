# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the KMS actions necessary to
# provision KMS keys in the Images account
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionkmskeys_doc" {
  statement {
    actions = [
      "kms:CreateAlias",
      "kms:CreateKey",
      "kms:DeleteAlias",
      "kms:DescribeKey",
      "kms:EnableKey",
      "kms:EnableKeyRotation",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:ListAliases",
      "kms:ListKeyPolicies",
      "kms:ListKeys",
      "kms:ListResourceTags",
      "kms:PutKeyPolicy",
      "kms:ScheduleKeyDeletion",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:UpdateAlias",
      "kms:UpdateKeyDescription",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "provisionkmskeys_policy" {
  description = var.provisionkmskeys_role_description
  name        = var.provisionkmskeys_role_name
  policy      = data.aws_iam_policy_document.provisionkmskeys_doc.json
}
