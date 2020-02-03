# IAM assume role policy document that allows assumption of the IAM role that
# allows full IAM administrator permissions
data "aws_iam_policy_document" "assume_provision_account_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${var.this_account_id}:role/${var.provision_account_role_name}",
    ]
  }
}

resource "aws_iam_policy" "assume_provision_account_role" {
  description = var.assume_provision_account_policy_description
  name        = var.assume_provision_account_policy_name
  policy      = data.aws_iam_policy_document.assume_provision_account_role_doc.json
}

# Attach the policy to the users_account_provisioners group
resource "aws_iam_group_policy_attachment" "users_account_provisioners" {
  group      = aws_iam_group.users_account_provisioners.name
  policy_arn = aws_iam_policy.assume_provision_account_role.arn
}
