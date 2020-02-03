# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to
# provision all AWS resources in the terraform account.
# ------------------------------------------------------------------------------

# We will also attach the IAMFullAccess policy to the role that uses
# this policy, so it will have all necessary permissions to provision
# all AWS resources in the terraform account.
data "aws_iam_policy_document" "provision_account_doc" {
  # Permissions necessary to manipulate the state bucket
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.state_bucket_name}",
    ]
  }

  # Permissions necessary to manipulate the state lock table
  statement {
    actions = [
      "dynamodb:*",
    ]
    resources = [
      "arn:aws:dynamodb:${var.aws_region}:${var.this_account_id}:table/${var.state_table_name}",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "provision_account_policy" {
  description = var.provision_account_role_description
  name        = var.provision_account_role_name
  policy      = data.aws_iam_policy_document.provision_account_doc.json
}
