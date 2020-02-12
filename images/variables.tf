# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "admin_usernames" {
  type        = list(string)
  description = "The usernames associated with the admin IAM user accounts."
}

variable "this_account_id" {
  description = "The ID of the account being configured."
}

variable "users_account_id" {
  description = "The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the Images account."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "assume_ec2amicreate_policy_description" {
  description = "The description to associate with the IAM policy that allows sufficient permissions to create AMIs via Packer in the Images account."
  default     = "Allow sufficient permissions to create AMIs via Packer in the Images account."
}

variable "assume_ec2amicreate_policy_name" {
  description = "The name to associate with the IAM policy that allows sufficient permissions to create AMIs via Packer in the Images account."
  default     = "Images-AssumeEC2AMICreate"
}

variable "account_provisioners_group_membership_name" {
  description = "The name to associate with the membership of the IAM group allowed to assume the role with sufficient permissions to provision the Images account."
  default     = "images_account_provisioners_membership"
}

variable "account_provisioners_group_name" {
  description = "The name to associate with the IAM group allowed to assume the role with sufficient permissions to provision the Images account."
  default     = "images_account_provisioners"
}

variable "assume_provisionaccount_policy_description" {
  description = "The description to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the Images account."
  default     = "Allow assumption of the ProvisionAccount role in the Images account."
}

variable "assume_provisionaccount_policy_name" {
  description = "The name to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the Images account."
  default     = "Images-AssumeProvisionAccount"
}

variable "aws_region" {
  description = "The AWS region where the non-global resources for the Images account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "ec2amicreate_role_description" {
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs via Packer."
  default     = "Allows sufficient permissions to create AMIs via Packer."
}

variable "ec2amicreate_role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs via Packer."
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
