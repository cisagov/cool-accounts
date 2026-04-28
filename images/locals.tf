# ------------------------------------------------------------------------------
# We can get the account ID of this account from the provider's caller
# identity.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "this" {
}

# ------------------------------------------------------------------------------
# Retrieve the information for all accounts in the organization.  This
# is used, for instance, to lookup the account IDs for the user
# account.
# ------------------------------------------------------------------------------
data "aws_organizations_organization" "cool" {
  provider = aws.organizationsreadonly
}

locals {
  # These help to minimize repetition in ACL rules
  tcp_and_udp = [
    "tcp",
    "udp",
  ]

  # Build the name of the third-party file storage bucket
  third_party_bucket_name = format("%s-%s", var.third_party_bucket_name_prefix, lower(terraform.workspace))

  # Get current Images account ID from Images provider
  this_account_id = data.aws_caller_identity.images.account_id

  # Look up current Images account name from AWS organizations provider
  this_account_name = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.name
    if account.id == local.this_account_id
  ][0]

  # Find the Users account by name
  users_account_id = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.id if account.name == "Users"
  ][0]
}
