# An IAM group for god-like users that are allowed to access the
# terraform backend, are IAM administrators for the Users account, and
# are allowed to assume any role that has a trust relationship with
# the Users account
resource "aws_iam_group" "gods" {
  name = var.gods_group_name
}

data "aws_iam_policy_document" "assume_any_role_anywhere_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::*:role/*"
    ]
  }
}

resource "aws_iam_policy" "assume_any_role_anywhere" {
  description = var.assume_any_role_anywhere_policy_description
  name        = var.assume_any_role_anywhere_policy_name
  policy      = data.aws_iam_policy_document.assume_any_role_anywhere_doc.json
}

# Attach the policy to the gods group
resource "aws_iam_group_policy_attachment" "assume_any_role_anywhere" {
  group      = aws_iam_group.gods.name
  policy_arn = aws_iam_policy.assume_any_role_anywhere.arn
}
