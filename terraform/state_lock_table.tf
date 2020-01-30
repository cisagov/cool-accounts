# ------------------------------------------------------------------------------
# Create the DynamoDB table that will be used for the Terraform state
# locking.
# ------------------------------------------------------------------------------

resource "aws_dynamodb_table" "state_lock_table" {
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key       = "LockID"
  name           = var.table_name
  read_capacity  = var.table_read_capacity
  write_capacity = var.table_write_capacity
  tags           = var.tags
}
