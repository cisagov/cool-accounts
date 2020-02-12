# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the users account to
# assume this role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.users_account_id}:root",
      ]
    }
  }
}
