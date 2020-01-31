# IAM assume role policy document that allows assumption of the IAM
# role that can terraform the terraform account.
data "aws_iam_policy_document" "assume_tf_createaccount_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      var.terraform_createaccount_role_arn
    ]
  }
}

resource "aws_iam_policy" "assume_tf_createaccount_role" {
  description = var.assume_tf_createaccount_policy_description
  name        = var.assume_tf_createaccount_policy_name
  policy      = data.aws_iam_policy_document.assume_tf_createaccount_role_doc.json
}

# Attach the policy to the terraform admin users group
resource "aws_iam_group_policy_attachment" "assume_tf_createaccount_role_attachment" {
  group      = aws_iam_group.terraform_account_terraformers.name
  policy_arn = aws_iam_policy.assume_tf_createaccount_role.arn
}
