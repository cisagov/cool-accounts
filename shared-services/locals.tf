# Retrieve the information for all accounts in the organization.  This
# is used, for instance, to lookup the account IDs for the user
# account.
data "aws_organizations_organization" "cool" {
  provider = aws.organizationsreadonly
}

locals {
  # Find the Users account by name and email
  users_account_id = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.id
    if account.name == "Users" && length(regexall("2020", account.email)) > 0
  ][0]
}
