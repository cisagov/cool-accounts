# ------------------------------------------------------------------------------
# We can get the account ID of this account from the provider's caller
# identity.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "this" {
}

# Retrieve the information for all accounts in the organization.  This
# is used, for instance, to lookup the account ID for the Users
# account.
data "aws_organizations_organization" "cool" {
  provider = aws.organizationsreadonly
}

# ------------------------------------------------------------------------------
# We can get the account ID of the DNS account from the default provider's
# caller identity.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "dns" {
}

locals {
  dns_account_id = data.aws_caller_identity.dns.account_id

  # Find the Users account
  users_account_id = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.id
    if account.name == "Users"
  ][0]
}
