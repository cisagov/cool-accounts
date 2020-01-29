# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "bucket_name" {
  description = "The name to use for the S3 bucket that will store the Terraform state."
  default     = "cisa-cool-terraform-state"
}

variable "table_name" {
  description = "The name to use for the DynamoDB table that will be used for Terraform state locking."
  default     = "cisa-cool-terraform-state-lock"
}

variable "table_read_capacity" {
  type        = number
  description = "The number of read units for the DynamoDB table that will be used for Terraform state locking."
  default     = 5
}

variable "table_write_capacity" {
  type        = number
  description = "The number of write units for the DynamoDB table that will be used for Terraform state locking."
  default     = 5
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
