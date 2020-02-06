# An IAM group for users allowed to provision the Audit account
resource "aws_iam_group" "audit_account_provisioners" {
  name = var.audit_account_provisioners_group_name
}
