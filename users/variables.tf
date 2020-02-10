# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "admin_usernames" {
  type        = map(string)
  description = "The usernames associated with the admin accounts to be created, which are allowed to access the terraform backend and are IAM administrators.  The format first.last is recommended.  The keys are the usernames and the values are empty strings (since they are not presently used). Example: { \"firstname1.lastname1\" = \"\",  \"firstname2.lastname2\" = \"\" }"
}

variable "this_account_id" {
  description = "The ID of the account being configured."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "assume_provisionaccount_policy_description" {
  description = "The description to associate with the IAM policy that allows assumption of the role to provision all AWS resources in this account."
  default     = "Allow assumption of the ProvisionAccount role."
}

variable "assume_provisionaccount_policy_name" {
  description = "The name to assign the IAM policy that allows assumption of the role to provision all AWS resources in this account."
  default     = "AssumeProvisionAccount"
}

variable "aws_region" {
  description = "The AWS region where the non-global resources for this account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "provisionaccount_role_description" {
  description = "The description to associate with the IAM role that allows access to provision all AWS resources in this account."
  default     = "Allows sufficient access to provision all AWS resources in this account."
}

variable "provisionaccount_role_name" {
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the users account."
  default     = "ProvisionAccount"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources provisioned."
  default     = {}
}

variable "users_account_provisioners_group_name" {
  description = "The name of the group to be created for users allowed to provision the users account."
  default     = "users_account_provisioners"
}
