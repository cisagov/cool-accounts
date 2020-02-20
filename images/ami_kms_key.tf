# ------------------------------------------------------------------------------
# Create the KMS key for encrypting AMIs in the Images account
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "ami_kms_doc" {
  statement {
    sid = "Enable IAM User Permissions"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.images.account_id}:root"]
    }

    actions = [
      "kms:*",
    ]

    resources = ["*"]
  }

  statement {
    sid = "Allow access for Key Administrators"

    principals {
      type = "AWS"
      # This role needs to be created before the key is provisioned,
      # so we can't use aws_iam_role.administerkmskeys_role.arn here.
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.images.account_id}:role/${var.administerkmskeys_role_name}"]
    }

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

  statement {
    sid = "Allow use of the key"

    # Wildcards (other than the global "*") are not allowed when specifying
    # a principal (e.g. "${aws_iam_role.ec2amicreate_role.arn}*"), so instead
    # we set the principal to "*" and restrict access via the condition
    # below (which does allow for a wildcard pattern match on the role ARN)
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "kms:CreateGrant",
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
      "kms:RetireGrant",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalArn"
      values = [
        "${aws_iam_role.ec2amicreate_role.arn}*"
      ]
    }
  }
}

resource "aws_kms_key" "amis" {
  description         = var.ami_kms_key_description
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.ami_kms_doc.json
  tags                = var.tags
}

resource "aws_kms_alias" "amis" {
  name          = "alias/${var.ami_kms_key_alias}"
  target_key_id = aws_kms_key.amis.key_id
}
