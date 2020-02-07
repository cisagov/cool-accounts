module "provisionaccount" {
  source = "../provisionaccount-role-tf-module"

  providers = {
    aws       = aws
    aws.users = aws.users
  }

  account_provisioners_group_membership_name = var.account_provisioners_group_membership_name
  account_provisioners_group_name            = var.account_provisioners_group_name
  admin_usernames                            = var.admin_usernames
  assume_provisionaccount_policy_description = var.assume_provisionaccount_policy_description
  assume_provisionaccount_policy_name        = var.assume_provisionaccount_policy_name
  new_account_id                             = var.this_account_id
  provisionaccount_role_description          = var.provisionaccount_role_description
  provisionaccount_role_name                 = var.provisionaccount_role_name
  tags = {
    Team        = "VM Fusion - Development"
    Application = "COOL - Pettifogger0 Account"
    Workspace   = "production"
  }
  users_account_id = var.users_account_id
}
