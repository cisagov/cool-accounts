# IAM assume role policy document that allows assumption of the IAM role that
# allows full IAM administrator permissions
data "aws_iam_policy_document" "assume_provisionaccount_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${var.this_account_id}:role/${var.provisionaccount_role_name}",
    ]
  }
}

resource "aws_iam_policy" "assume_provisionaccount_role" {
  description = var.assume_provisionaccount_policy_description
  name        = var.assume_provisionaccount_policy_name
  policy      = data.aws_iam_policy_document.assume_provisionaccount_role_doc.json
}
