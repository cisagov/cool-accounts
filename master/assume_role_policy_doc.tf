# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the Users account and all
# assessment accounts to assume this role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      # Delegate access to this role to the Users account and all
      # assessment accounts.
      identifiers = concat([local.users_account_id], local.assessment_account_ids)
    }
  }
}
