# IAM assume role policy document that allows assumption of the IAM role that
# allows full IAM administrator permissions
data "aws_iam_policy_document" "assume_iam_admin_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${var.this_account_id}:role/${var.iam_admin_role_name}",
    ]
  }
}

resource "aws_iam_policy" "assume_iam_admin_role" {
  description = var.assume_iam_admin_policy_description
  name        = var.assume_iam_admin_policy_name
  policy      = data.aws_iam_policy_document.assume_iam_admin_role_doc.json
}

# Attach the policy to the IAM admins group
resource "aws_iam_group_policy_attachment" "iam_admin" {
  group      = aws_iam_group.iam_admins
  policy_arn = aws_iam_policy.assume_iam_admin_role.arn
}
