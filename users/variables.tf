# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "godlike_usernames" {
  type        = list(string)
  description = "The usernames associated with the god-like accounts to be created, which are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account.  The format first.last is recommended.  Example: [\"firstname1.lastname1\",  \"firstname2.lastname2\"]."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "assume_any_role_anywhere_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
  default     = "Allow assumption of any role in any account, so long as it has a trust relationship with the Users account."
}

variable "assume_any_role_anywhere_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
  default     = "AssumeAnyRoleAnywhere"
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for this account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "gods_group_name" {
  type        = string
  description = "The name of the group to be created for the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
  default     = "gods"
}

variable "password_policy_allow_users_to_change_password" {
  type        = bool
  description = "Whether to allow users to change their own passwords."
  default     = true
}

variable "password_policy_minimum_password_length" {
  type        = number
  description = "The minimum required length for IAM user passwords."
  default     = 12
}

variable "password_policy_require_lowercase_characters" {
  type        = bool
  description = "Whether IAM user passwords are required to contain at least one lowercase letter from the Latin alphabet (a-z)."
  default     = true
}

variable "password_policy_require_numbers" {
  type        = bool
  description = "Whether IAM user passwords are required to contain at least one number."
  default     = true
}

variable "password_policy_require_symbols" {
  type        = bool
  description = "Whether IAM user passwords are required to contain at least one non-alphanumeric character (! @ # $ % ^ & * ( ) _ + - = [ ] { } | ')."
  default     = true
}

variable "password_policy_require_uppercase_characters" {
  type        = bool
  description = "Whether IAM user passwords are required to contain at least one uppercase letter from the Latin alphabet (A-Z)."
  default     = true
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows access to provision all AWS resources in the Users account."
  default     = "Allows sufficient access to provision all AWS resources in the Users account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Users account."
  default     = "ProvisionAccount"
}

variable "self_managed_creds_with_mfa_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  default     = "Allows sufficient access for users to administer their own user accounts, requiring multi-factor authentication (MFA)."
}

variable "self_managed_creds_with_mfa_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  default     = "SelfManagedCredsWithMFA"
}

variable "self_managed_creds_without_mfa_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  default     = "Allows sufficient access for users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
}

variable "self_managed_creds_without_mfa_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  default     = "SelfManagedCredsWithoutMFA"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
