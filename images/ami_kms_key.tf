# ------------------------------------------------------------------------------
# Create the KMS key for encrypting AMIs in the Images account
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "ami_kms_doc" {
  statement {
    actions = [
      "kms:*",
    ]
    resources = ["*"]
    sid       = "Enable IAM User Permissions"

    principals {
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.images.account_id}:root",
      ]
      type = "AWS"
    }
  }

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
    sid       = "Allow access for Key Administrators"

    principals {
      type = "AWS"
      # This role needs to be created before the key is provisioned,
      # so we can't use aws_iam_role.administerkmskeys_role.arn here.
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.images.account_id}:role/${var.administerkmskeys_role_name}",
      ]
    }
  }

  statement {
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
    sid       = "Allow use of the key"

    condition {
      test = "StringLike"
      values = [
        "${aws_iam_role.ec2amicreate_role.arn}*",
      ]
      variable = "aws:PrincipalArn"
    }
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
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom",
    ]
    resources = ["*"]
    sid       = "Allow use of the key for launching EC2 instances"

    condition {
      test = "StringLike"
      # The ProvisionAccount role ARNs for the env* accounts, the
      # playground, the Shared Services account, and the
      # extra-organizational accounts, as well as the Terraformer role
      # ARNs for the env* accounts.
      #
      # Any other accounts that need to launch EC2 instances from AMIs
      # encrypted using our key should also be listed here.
      #
      # Regex guide:
      # - "^env[0-9]*$": Dynamic assessment accounts
      # - "^Playground Legacy$": Legacy playground account
      # - "^Shared Services$": Shared Services account
      values = concat([
        for account in data.aws_organizations_organization.cool.accounts :
        "arn:aws:iam::${account.id}:role/ProvisionAccount"
        if length(regexall("^env[0-9]*$|^Playground Legacy$|^Shared Services$", account.name)) > 0
        ], [
        for account in data.aws_organizations_organization.cool.accounts :
        "arn:aws:iam::${account.id}:role/Terraformer"
        if length(regexall("^env[0-9]*$", account.name)) > 0
        ], [
        for account_id in var.extraorg_account_ids :
        "arn:aws:iam::${account_id}:role/ProvisionAccount"
        ], [
        for account_id in var.extraorg_account_ids :
        "arn:aws:iam::${account_id}:role/Terraformer"
      ])
      variable = "aws:PrincipalArn"
    }
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
  }
}

resource "aws_kms_key" "amis" {
  description         = var.ami_kms_key_description
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.ami_kms_doc.json
}

resource "aws_kms_alias" "amis" {
  name          = "alias/${var.ami_kms_key_alias}"
  target_key_id = aws_kms_key.amis.key_id
}
