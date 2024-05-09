# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the users account to
# assume this role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      identifiers = [
        "arn:aws:iam::${local.users_account_id}:root",
      ]
      type = "AWS"
    }
  }
}
