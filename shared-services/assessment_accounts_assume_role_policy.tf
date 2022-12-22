# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the dynamic assessment accounts to
# assume a role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "asseessment_account_assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = local.assessment_account_ids
    }
  }
}
