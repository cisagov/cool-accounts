# IAM assume role policy document that allows assumption of the IAM
# role that can provision the Audit account.
data "aws_iam_policy_document" "assume_audit_provisionaccount_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${var.audit_account_id}:role/ProvisionAccount"
    ]
  }
}

resource "aws_iam_policy" "assume_audit_provisionaccount_role" {
  description = var.assume_audit_provisionaccount_policy_description
  name        = var.assume_audit_provisionaccount_policy_name
  policy      = data.aws_iam_policy_document.assume_audit_provisionaccount_role_doc.json
}

# Attach the policy to the Audit provisioner users group
resource "aws_iam_group_policy_attachment" "assume_audit_provisionaccount_role_attachment" {
  group      = aws_iam_group.audit_account_provisioners.name
  policy_arn = aws_iam_policy.assume_audit_provisionaccount_role.arn
}
