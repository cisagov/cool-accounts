# IAM assume role policy document that allows assumption of the IAM
# role that can provision the shared services account.
data "aws_iam_policy_document" "assume_sharedservices_provisionaccount_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${var.sharedservices_account_id}:role/${var.provision_account_role_name}"
    ]
  }
}

resource "aws_iam_policy" "assume_sharedservices_provisionaccount_role" {
  description = var.assume_sharedservices_provisionaccount_policy_description
  name        = var.assume_sharedservices_provisionaccount_policy_name
  policy      = data.aws_iam_policy_document.assume_sharedservices_provisionaccount_role_doc.json
}

# Attach the policy to the shared services provisioner users group
resource "aws_iam_group_policy_attachment" "assume_sharedservices_provisionaccount_role_attachment" {
  group      = aws_iam_group.sharedservices_account_provisioners.name
  policy_arn = aws_iam_policy.assume_sharedservices_provisionaccount_role.arn
}
