# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the KMS actions necessary to
# administer KMS keys for AMIs in the Images account
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "administeramikmskeys_doc" {
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

resource "aws_iam_policy" "administeramikmskeys_policy" {
  description = var.administeramikmskeys_role_description
  name        = var.administeramikmskeys_role_name
  policy      = data.aws_iam_policy_document.administeramikmskeys_doc.json
}
