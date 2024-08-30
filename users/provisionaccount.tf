module "provisionaccount" {
  source = "github.com/cisagov/provisionaccount-role-tf-module?ref=feature%2Fadd-permissions-for-disable-inactive-iam-users-tf-module"

  provisionaccount_role_description = var.provisionaccount_role_description
  provisionaccount_role_name        = var.provisionaccount_role_name
  users_account_id                  = data.aws_caller_identity.users.account_id
}
