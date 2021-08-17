# ------------------------------------------------------------------------------
# Retrieve the information for all accouts in the organization.  This is used
# to lookup the account IDs for all assessment accounts.
# ------------------------------------------------------------------------------
data "aws_organizations_organization" "cool" {
}

# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------
locals {
  # Look up all assessment account IDs from AWS organizations provider
  assessment_account_ids = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.id
    if length(regexall("^env\\d+", account.name)) > 0
  ]
}
