# The god-like users being created
resource "aws_iam_user" "gods" {
  for_each = toset(var.godlike_usernames)

  name = each.key
  tags = var.tags
}

# IAM policy that allows these users to administer their own user
# accounts.  This policy is pretty much copied from here:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html
#
# The main difference is that we don't require these users to be
# authenticated with MFA, since these accounts will only be accessed
# programatically (i.e. not via the AWS web console) where MFA is not
# an option.
data "aws_iam_policy_document" "iam_self_admin_docs" {
  for_each = toset(var.godlike_usernames)

  # Allow users to view their own account information
  statement {
    effect = "Allow"

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListVirtualMFADevices",
    ]

    resources = [
      "*",
    ]
  }

  # Allow users to administer their own passwords
  statement {
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
    ]

    resources = [
      aws_iam_user.gods[each.key].arn,
    ]
  }

  # Allow users to administer their own access keys
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]

    resources = [
      aws_iam_user.gods[each.key].arn,
    ]
  }

  # Allow users to administer their own signing certificates
  statement {
    effect = "Allow"

    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
    ]

    resources = [
      aws_iam_user.gods[each.key].arn,
    ]
  }

  # Allow users to administer their own ssh public keys
  statement {
    effect = "Allow"

    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = [
      aws_iam_user.gods[each.key].arn,
    ]
  }

  # Allow users to administer their own git credentials
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential",
    ]

    resources = [
      aws_iam_user.gods[each.key].arn,
    ]
  }

  # Allow users to administer their own virtual MFA device
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]

    resources = [
      # The MFA ARN is identical to that of the user, except that the
      # text "user" is replaced by "mfa"
      replace(aws_iam_user.gods[each.key].arn, "user", "mfa"),
    ]
  }

  # Allow users to administer their own (non-virtual) MFA device
  statement {
    effect = "Allow"

    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice",
    ]

    resources = [
      aws_iam_user.gods[each.key].arn,
    ]
  }
}

# The IAM self-administration policy for our gods
resource "aws_iam_user_policy" "gods" {
  for_each = toset(var.godlike_usernames)

  name   = "SelfManagedCredsWithoutMFA"
  user   = each.key
  policy = data.aws_iam_policy_document.iam_self_admin_docs[each.key].json
}
