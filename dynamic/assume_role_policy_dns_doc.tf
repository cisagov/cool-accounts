# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the DNS account to
# assume this role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_dns_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${local.dns_account_id}:root",
      ]
    }
  }
}
