module "provisionaccount" {
  source = "../.."

  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  tags                              = var.tags
  users_account_id                  = var.users_account_id
}
