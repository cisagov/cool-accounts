# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "godlike_usernames" {
  description = "The usernames associated with the god-like accounts to be created, which are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account.  The format first.last is recommended.  Example: [\"firstname1.lastname1\",  \"firstname2.lastname2\"]."
  type        = list(string)
}

variable "lambda_bucket_name" {
  description = "The name of the S3 bucket containing the Lambda function deployment package to disable inactive IAM users."
  type        = string
}

variable "lambda_key" {
  description = "The S3 key associated with the Lambda function deployment package to disable inactive IAM users."
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "assume_any_role_anywhere_policy_description" {
  default     = "Allow assumption of any role in any account, so long as it has a trust relationship with the Users account."
  description = "The description to associate with the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
  type        = string
}

variable "assume_any_role_anywhere_policy_name" {
  default     = "AssumeAnyRoleAnywhere"
  description = "The name to assign the IAM policy that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources for this account are to be provisioned (e.g. \"us-east-1\")."
  type        = string
}

variable "gods_group_name" {
  default     = "gods"
  description = "The name of the group to be created for the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
  type        = string
}

variable "password_policy_allow_users_to_change_password" {
  default     = true
  description = "Whether to allow users to change their own passwords."
  type        = bool
}

variable "password_policy_minimum_password_length" {
  default     = 12
  description = "The minimum required length for IAM user passwords."
  type        = number
}

variable "password_policy_require_lowercase_characters" {
  default     = true
  description = "Whether IAM user passwords are required to contain at least one lowercase letter from the Latin alphabet (a-z)."
  type        = bool
}

variable "password_policy_require_numbers" {
  default     = true
  description = "Whether IAM user passwords are required to contain at least one number."
  type        = bool
}

variable "password_policy_require_symbols" {
  default     = true
  description = "Whether IAM user passwords are required to contain at least one non-alphanumeric character (! @ # $ % ^ & * ( ) _ + - = [ ] { } | ')."
  type        = bool
}

variable "password_policy_require_uppercase_characters" {
  default     = true
  description = "Whether IAM user passwords are required to contain at least one uppercase letter from the Latin alphabet (A-Z)."
  type        = bool
}

variable "provisionaccount_role_description" {
  default     = "Allows sufficient access to provision all AWS resources in the Users account."
  description = "The description to associate with the IAM role that allows access to provision all AWS resources in the Users account."
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Users account."
  type        = string
}

variable "self_managed_creds_with_mfa_policy_description" {
  default     = "Allows sufficient access for users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  type        = string
}

variable "self_managed_creds_with_mfa_policy_name" {
  default     = "SelfManagedCredsWithMFA"
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  type        = string
}

variable "self_managed_creds_without_mfa_policy_description" {
  default     = "Allows sufficient access for users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  description = "The description to associate with the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  type        = string
}

variable "self_managed_creds_without_mfa_policy_name" {
  default     = "SelfManagedCredsWithoutMFA"
  description = "The name to assign the IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}
