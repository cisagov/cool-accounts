module "provisionaccount" {
  source = "github.com/cisagov/provisionaccount-role-tf-module"

  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  users_account_id                  = local.users_account_id
}

# Attach a policy allowing this role to read from the S3 bucket in the
# Terraform account where Lambda deployment packages are stored.
resource "aws_iam_role_policy_attachment" "read_lambda_bucket" {
  policy_arn = aws_iam_policy.read_lambda_bucket_policy.arn
  role       = module.provisionaccount.provisionaccount_role.name
}
