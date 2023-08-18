# ------------------------------------------------------------------------------
# Define the IAM user password policy for the Users account.
# ------------------------------------------------------------------------------

resource "aws_iam_account_password_policy" "users" {
  allow_users_to_change_password = var.password_policy_allow_users_to_change_password
  minimum_password_length        = var.password_policy_minimum_password_length
  require_lowercase_characters   = var.password_policy_require_lowercase_characters
  require_numbers                = var.password_policy_require_numbers
  require_symbols                = var.password_policy_require_symbols
  require_uppercase_characters   = var.password_policy_require_uppercase_characters
}
