# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to administer the Single Sign-On (SSO) resources required in this account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "administersso_policy_doc" {
  statement {
    actions = [
      "identitystore:ListUsers",
      "identitystore:ListGroups",
      "sso:CreateAccountAssignment",
      "sso:DeleteAccountAssignment",
      "sso:DescribeAccountAssignmentCreationStatus",
      "sso:DescribeAccountAssignmentDeletionStatus",
      "sso:DescribePermissionSet",
      "sso:ListAccountAssignments",
      "sso:ListInstances",
      "sso:ListPermissionSets",
      "sso:ListTagsForResource"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "administersso_policy" {
  description = var.administersso_role_description
  name        = var.administersso_role_name
  policy      = data.aws_iam_policy_document.administersso_policy_doc.json
}
