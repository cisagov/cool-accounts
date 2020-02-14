# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "users_account_id" {
  description = "The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the Images account."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region where the non-global resources for the Images account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "ec2amicreate_role_description" {
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account."
  default     = "Allows sufficient permissions to create AMIs in the Images account."
}

variable "ec2amicreate_role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account."
  default     = "EC2AMICreate"
}

variable "provisionaccount_role_description" {
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all AWS resources in the Images account."
  default     = "Allows sufficient permissions to provision all AWS resources in the Images account."
}

variable "provisionaccount_role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all AWS resources in the Images account."
  default     = "ProvisionAccount"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources provisioned."
  default     = {}
}
