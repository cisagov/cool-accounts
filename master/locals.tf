# ------------------------------------------------------------------------------
# We can get the account ID of this account from the provider's caller
# identity.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "this" {
}

# ------------------------------------------------------------------------------
# Retrieve the information for all accounts in the organization.  This
# is used, for instance, to lookup the account IDs for all assessment
# accounts.
# ------------------------------------------------------------------------------
data "aws_organizations_organization" "cool" {
}

# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------
locals {
  # Look up all assessment account IDs via the AWS organizations
  # provider.
  assessment_account_ids = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.id
    if length(regexall("^env[[:digit:]]+$", account.name)) > 0
  ]

  # Find the Users account by name and email
  users_account_id = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.id if account.name == "Users"
  ][0]
}
