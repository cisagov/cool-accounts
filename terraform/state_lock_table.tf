# ------------------------------------------------------------------------------
# Create the DynamoDB table that will be used for the Terraform state
# locking.
# ------------------------------------------------------------------------------

resource "aws_dynamodb_table" "state_lock_table" {
  # We can't perform this action until our policy is in place.
  depends_on = [
    aws_iam_role_policy_attachment.provisionbackend_policy_attachment,
  ]

  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key       = "LockID"
  name           = var.state_table_name
  read_capacity  = var.state_table_read_capacity
  write_capacity = var.state_table_write_capacity
}
