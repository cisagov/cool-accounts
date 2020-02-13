# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "state_bucket_name" {
  description = "The name to use for the S3 bucket that will store the Terraform state."
}

variable "this_account_id" {
  description = "The ID of the account being configured."
}

variable "users_account_id" {
  description = "The ID of the users account.  This account will be allowed to assume the role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend, as well as the role that allows sufficient permissions to provision all AWS resources in the Terraform account."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "access_terraform_backend_role_description" {
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "Allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

variable "access_terraform_backend_role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "AccessTerraformBackend"
}

variable "aws_region" {
  description = "The AWS region where the non-global resources for this account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "provisionaccount_role_description" {
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all AWS resources in the Terraform account."
  default     = "Allows sufficient permissions to provision all AWS resources in the Terraform account."
}

variable "provisionaccount_role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all AWS resources in the terraform account."
  default     = "ProvisionAccount"
}

variable "state_table_name" {
  description = "The name to use for the DynamoDB table that will be used for Terraform state locking."
  default     = "terraform-state-lock"
}

variable "state_table_read_capacity" {
  type        = number
  description = "The number of read units for the DynamoDB table that will be used for Terraform state locking."
  default     = 20
}

variable "state_table_write_capacity" {
  type        = number
  description = "The number of write units for the DynamoDB table that will be used for Terraform state locking."
  default     = 20
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources provisioned."
  default     = {}
}
