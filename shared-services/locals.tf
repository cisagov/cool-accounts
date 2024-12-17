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

locals {
  # Find the Shared Services account name by id.
  sharedservices_account_name = [
    for x in data.aws_organizations_organization.cool.accounts :
    x.name if x.id == data.aws_caller_identity.sharedservices.account_id
  ][0]

  # Determine the dynamic assessment account ("env*") IDs that are the same
  # type (production, staging, etc.) as the Shared Services account.
  # Account name format:  "ACCOUNT_NAME (ACCOUNT_TYPE)"
  #         For example:  "Shared Services (Production)"
  # NOTE: Originally, Shared Services (and dynamic) account names followed the
  # "ACCOUNT_NAME (ACCOUNT_TYPE)" format above, but our thinking has changed and
  # in newer environments the accounts are simply called "Shared Services" and
  # "env0" (for example).  However, until all legacy environments have been
  # migrated to this new naming scheme, we must check the Shared Services
  # account name via the regex below to determine whether we are using the
  # legacy naming scheme or not.
  sharedservices_account_name_type = length(regexall("\\(([^()]*)\\)", local.sharedservices_account_name)) == 1 ? "legacy" : "current"

  assessment_account_name_regex = local.sharedservices_account_name_type == "legacy" ? format("^env[[:digit:]]+ \\(%s\\)$", trim(split("(", local.sharedservices_account_name)[1], ")")) : "^env[[:digit:]]+$"

  # Build a list of dynamic assessment account IDs whose account names match our
  # regex.
  assessment_account_ids = [
    for account in data.aws_organizations_organization.cool.non_master_accounts :
    account.id
  if length(regexall(local.assessment_account_name_regex, account.name)) > 0]

  # Find the Users account
  users_account_id = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.id
    if account.name == "Users"
  ][0]
}
