# ------------------------------------------------------------------------------
# We can get the account ID of this account from the provider's caller
# identity.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "this" {
}
