# ------------------------------------------------------------------------------
# We can get the account ID of the Images account from the
# provider's caller identity.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "images" {
}
