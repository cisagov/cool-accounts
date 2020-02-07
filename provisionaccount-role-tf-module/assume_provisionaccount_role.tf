# IAM assume role policy document that allows assumption of the IAM
# role that can provision the new account.
data "aws_iam_policy_document" "assume_provisionaccount_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${var.new_account_id}:role/ProvisionAccount"
    ]
  }
}

resource "aws_iam_policy" "assume_provisionaccount_role" {
  provider = aws.users

  description = var.assume_provisionaccount_policy_description
  name        = var.assume_provisionaccount_policy_name
  policy      = data.aws_iam_policy_document.assume_provisionaccount_role_doc.json
}

# Attach the policy to the provisioner users group for the new account
resource "aws_iam_group_policy_attachment" "assume_provisionaccount_role_attachment" {
  provider = aws.users

  group      = aws_iam_group.account_provisioners.name
  policy_arn = aws_iam_policy.assume_provisionaccount_role.arn
}
