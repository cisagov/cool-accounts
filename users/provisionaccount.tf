module "provisionaccount" {
  source = "../provisionaccount-role-tf-module"

  new_account_id                    = var.this_account_id
  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  tags                              = var.tags
  users_account_id                  = var.this_account_id
}
