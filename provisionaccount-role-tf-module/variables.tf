# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "account_provisioners_group_membership_name" {
  description = "The name to associate with the membership of the IAM group allowed to assume the role with sufficient permissions to provision the new account (e.g. \"dns_account_provisioners_membership\")."
}

variable "account_provisioners_group_name" {
  description = "The name to associate with the IAM group allowed to assume the role with sufficient permissions to provision the new account (e.g. \"dns_account_provisioners\")."
}

variable "admin_usernames" {
  type        = list(string)
  description = "The usernames associated with the admin IAM user accounts (e.g. [\"first.last\", \"first2.last2\"]).  Note that these user accounts will not be created and must exist."
}

variable "assume_provisionaccount_policy_description" {
  description = "The description to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the new account (e.g. \"Allow assumption of the ProvisionAccount role in the DNS account\")."
}

variable "assume_provisionaccount_policy_name" {
  description = "The name to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the new account (e.g. \"DNS-AssumeProvisionAccount\")."
}

variable "new_account_id" {
  description = "The ID of the account being configured."
}

variable "provisionaccount_role_description" {
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all AWS resources in the new account (e.g. \"Allows sufficient permissions to provision all AWS resources in the DNS account.\")."
}

variable "provisionaccount_role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all AWS resources in the new account (e.g. \"ProvisionAccount\")."
}

variable "users_account_id" {
  description = "The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the new account."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region where the non-global resources for the new account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources provisioned."
  default     = {}
}
