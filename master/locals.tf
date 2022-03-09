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
  #
  # Note that this code works in our current "both staging and
  # production in the same organization" arrangement, and it will also
  # work in the future "staging, production, dev, etc. in separate
  # organizations" arrangement.
  assessment_account_ids = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.id
    if length(regexall("^env\\d+", account.name)) > 0
  ]

  # Find the Users account by name and email
  users_account_id = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.id if account.name == "Users"
  ][0]
}
