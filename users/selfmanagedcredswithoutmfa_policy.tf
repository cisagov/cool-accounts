# ------------------------------------------------------------------------------
# IAM policy that allows users to administer their own user
# accounts.  This policy is pretty much copied from here:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html
#
# The main difference is that we don't require these users to be
# authenticated with MFA, since these accounts will be accessed
# programatically (i.e. not via the AWS web console) where MFA is not
# an option.
#
# Note that IAM policy variables (e.g. "aws:username") are used below. For
# reference, refer to:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "self_managed_creds_without_mfa" {
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
      "arn:aws:iam::*:user/&{aws:username}",
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
      "arn:aws:iam::*:user/&{aws:username}",
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
      "arn:aws:iam::*:user/&{aws:username}",
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
      "arn:aws:iam::*:user/&{aws:username}",
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
      "arn:aws:iam::*:user/&{aws:username}",
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
      "arn:aws:iam::*:mfa/*",
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
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "self_managed_creds_without_mfa" {
  description = var.self_managed_creds_without_mfa_policy_description
  name        = var.self_managed_creds_without_mfa_policy_name
  policy      = data.aws_iam_policy_document.self_managed_creds_without_mfa.json
}
