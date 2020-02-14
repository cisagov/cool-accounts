# ------------------------------------------------------------------------------
# We can get the account ID of the Users account from the provider's
# caller identity.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "users" {
}
