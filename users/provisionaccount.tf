module "provisionaccount" {
  source = "../provisionaccount-role-tf-module"

  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  tags                              = var.tags
  users_account_id                  = data.aws_caller_identity.users.account_id
}
