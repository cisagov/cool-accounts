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
      type        = "AWS"
      identifiers = ["${aws_iam_role.administeramikmskeys_role.arn}"]
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

    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_role.ec2amicreate_role.arn}"]
    }

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
    ]

    resources = ["*"]
  }
}

resource "aws_kms_key" "amis" {
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.ami_kms_doc.json
  tags                = var.tags
}

resource "aws_kms_alias" "amis" {
  name          = "alias/${var.ami_kms_key_alias}"
  target_key_id = aws_kms_key.amis.key_id
}
