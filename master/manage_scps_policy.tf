# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to manage service
# control policies (SCPs) (see cisagov/cool-master-org-policies).  Access is
# limited to SCPs with the expected Application tag so that the (untagged) SCPs
# created by Control Tower cannot be modified.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "manage_scps_doc" {
  # Allow creation of SCPs, but only with the expected Application tag
  statement {
    actions = [
      "organizations:CreatePolicy",
    ]
    condition {
      test     = "StringEquals"
      values   = [var.manage_scps_application_tag]
      variable = "aws:RequestTag/Application"
    }
    condition {
      test     = "StringEquals"
      values   = ["SERVICE_CONTROL_POLICY"]
      variable = "organizations:PolicyType"
    }
    resources = ["*"]
    sid       = "AllowCreatingTaggedSCPs"
  }

  # Allow management of SCPs that already have the expected Application tag
  statement {
    actions = [
      "organizations:AttachPolicy",
      "organizations:DeletePolicy",
      "organizations:DetachPolicy",
      "organizations:UpdatePolicy",
    ]
    condition {
      test     = "StringEquals"
      values   = [var.manage_scps_application_tag]
      variable = "aws:ResourceTag/Application"
    }
    resources = [
      "arn:aws:organizations::${data.aws_caller_identity.this.account_id}:policy/${data.aws_organizations_organization.cool.id}/service_control_policy/*",
    ]
    sid = "AllowManagingTaggedSCPs"
  }

  # Allow tagging of SCPs that already have the expected Application tag, so
  # that tag cannot be added to other SCPs.  The Application tag itself cannot
  # be changed or removed, since that would make the SCP unmanageable.
  statement {
    actions = [
      "organizations:TagResource",
      "organizations:UntagResource",
    ]
    condition {
      test     = "StringEquals"
      values   = [var.manage_scps_application_tag]
      variable = "aws:ResourceTag/Application"
    }
    condition {
      test     = "ForAllValues:StringNotEquals"
      values   = ["Application"]
      variable = "aws:TagKeys"
    }
    resources = [
      "arn:aws:organizations::${data.aws_caller_identity.this.account_id}:policy/${data.aws_organizations_organization.cool.id}/service_control_policy/*",
    ]
    sid = "AllowTaggingTaggedSCPs"
  }

  # AttachPolicy and DetachPolicy are also authorized against the (untagged)
  # target, so the targets must be allowed separately.
  statement {
    actions = [
      "organizations:AttachPolicy",
      "organizations:DetachPolicy",
    ]
    condition {
      test     = "StringEquals"
      values   = ["SERVICE_CONTROL_POLICY"]
      variable = "organizations:PolicyType"
    }
    resources = [
      "arn:aws:organizations::${data.aws_caller_identity.this.account_id}:account/${data.aws_organizations_organization.cool.id}/*",
      "arn:aws:organizations::${data.aws_caller_identity.this.account_id}:ou/${data.aws_organizations_organization.cool.id}/ou-*",
      "arn:aws:organizations::${data.aws_caller_identity.this.account_id}:root/${data.aws_organizations_organization.cool.id}/r-*",
    ]
    sid = "AllowAttachingAndDetachingSCPsToTargets"
  }
}

# The IAM policy
resource "aws_iam_policy" "manage_scps_policy" {
  description = var.manage_scps_policy_description
  name        = var.manage_scps_policy_name
  policy      = data.aws_iam_policy_document.manage_scps_doc.json
}
