# ------------------------------------------------------------------------------
# Create the DynamoDB table that will be used for the Terraform state
# locking.
# ------------------------------------------------------------------------------

resource "aws_dynamodb_table" "the_table" {
  name           = var.table_name
  read_capacity  = var.table_read_capacity
  write_capacity = var.table_write_capacityle
  tags           = var.tags
}
