# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "access_backend_terraform_role_arn" {
  type        = string
  description = "The ARN of the delegated role that allows access to the terraform backend."
}

variable "backend_terraform_users" {
  type        = list(string)
  description = "The usernames associated with the accounts to be created and allowed to access the terraform backend.  The format first.last is recommended."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}
