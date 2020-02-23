# ------------------------------------------------------------------------------
# Create the IAM policy that allows read-only access to all AWS
# Organizations information.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "organizationsreadonly_doc" {
  statement {
    actions = [
      "organizations:Describe*",
      "organizations:List*",
    ]
    resources = [
      "arn:aws:organizations::${data.aws_caller_identity.master.account_id}:*",
      "arn:aws:organizations::aws:policy/*",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "organizationsreadonly_policy" {
  description = var.organizationsreadonly_role_description
  name        = var.organizationsreadonly_role_name
  policy      = data.aws_iam_policy_document.organizationsreadonly_doc.json
}
