# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the Users account to
# assume this role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_users_only_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      # Delegate access to this role to the Users account only.
      identifiers = [local.users_account_id]
    }
  }
}
