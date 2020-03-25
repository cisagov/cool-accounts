# ------------------------------------------------------------------------------
# Create the KMS key for encrypting AMIs in the Images account
# ------------------------------------------------------------------------------

# We can extract the IDs of all organization accounts from this data
# resource.  It is used toward the end of the aws_iam_policy_document
# data resource that follows.
data "aws_organizations_organization" "cool" {
  provider = aws.organizationsreadonly
}

data "aws_iam_policy_document" "ami_kms_doc" {
  statement {
    sid = "Enable IAM User Permissions"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.images.account_id}:root",
      ]
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
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.images.account_id}:role/${var.administerkmskeys_role_name}",
      ]
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

    # Wildcards (other than the global "*") are not allowed when
    # specifying a principal
    # (e.g. "${aws_iam_role.ec2amicreate_role.arn}*"), so instead we
    # set the principal to "*" and restrict access via the condition
    # below (which does allow for a wildcard pattern match on the role
    # ARN).
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
        "${aws_iam_role.ec2amicreate_role.arn}*",
      ]
    }
  }

  statement {
    sid = "Allow use of the key for launching EC2 instances"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalArn"
      # The ProvisionAccount role ARNs for the env* accounts, the
      # playground, and the Shared Services account.  Any accounts
      # that need to launch EC2 instances from AMIs encrypted using
      # our key should be listed here.
      values = [
        for account in data.aws_organizations_organization.cool.accounts :
        "arn:aws:iam::${account.id}:role/ProvisionAccount"
        if length(regexall("^env[0-9]* \\(${local.this_account_type}\\)$|^Playground Legacy \\(${local.this_account_type}\\)$|^Shared Services \\(${local.this_account_type}\\)$", account.name)) > 0
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
