locals {
  # These help to minimize repetition in ACL rules
  tcp_and_udp = [
    "tcp",
    "udp",
  ]

  # Get current Images account ID from Images provider
  this_account_id = data.aws_caller_identity.images.account_id

  # Look up current Images account name from AWS organizations provider
  this_account_name = [
    for account in data.aws_organizations_organization.cool.accounts :
    account.name
    if account.id == local.this_account_id
  ][0]

  # Determine Images account type based on AWS account name
  # Account name format:  "ACCOUNT_NAME (ACCOUNT_TYPE)"
  #         For example:  "Images (Production)"
  this_account_type = length(regexall("\\((.*?)\\)", local.this_account_name)) == 1 ? regex("\\((.*?)\\)", local.this_account_name)[0] : "Unknown"
}
