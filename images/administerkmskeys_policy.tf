# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the KMS actions necessary to
# administer all KMS keys in the Images account.
#
# NOTE: There may be a future need to create a policy that only allows
# administration of the KMS key used to encrypt AMIs, but at this time
# such a policy is not required.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "administerkmskeys_doc" {
  statement {
    actions = [
      "kms:CancelKeyDeletion",
      "kms:Create*",
      "kms:Delete*",
      "kms:Describe*",
      "kms:Disable*",
      "kms:Enable*",
      "kms:Get*",
      "kms:List*",
      "kms:Put*",
      "kms:Revoke*",
      "kms:ScheduleKeyDeletion",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:Update*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "administerkmskeys_policy" {
  description = var.administerkmskeys_role_description
  name        = var.administerkmskeys_role_name
  policy      = data.aws_iam_policy_document.administerkmskeys_doc.json
}
