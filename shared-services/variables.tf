# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for the Shared Services account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  default     = "Allows sufficient permissions to provision all AWS resources in the Shared Services account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  default     = "ProvisionAccount"
}

variable "provisionssmdocument_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the SSM Document resource in the Shared Services account."
  default     = "Allows sufficient permissions to provision the SSM Document resource in the Shared Services account."
}

variable "provisionssmdocument_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the SSM Document resource in the Shared Services account."
  default     = "ProvisionSSMDocument"
}

variable "ssmsession_role_description" {
  type        = string
  description = "The description to associate with the IAM role (and policy) that allows creation of SSM SessionManager sessions to any EC2 instance in this account."
  default     = "Allows creation of SSM SessionManager sessions to any EC2 instance in this account."
}

variable "ssmsession_role_name" {
  type        = string
  description = "The name to assign the IAM role (and policy) that allows creation of SSM SessionManager sessions to any EC2 instance in this account."
  default     = "StartStopSSMSession"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
