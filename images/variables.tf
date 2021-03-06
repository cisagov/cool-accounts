# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "users_account_id" {
  type        = string
  description = "The ID of the users account.  This account will be allowed to assume the role that allows sufficient permissions to provision all AWS resources in the Images account."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "administerkmskeys_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer all KMS keys in the Images account."
  default     = "Allows sufficient permissions to administer all KMS keys in the Images account."
}

variable "administerkmskeys_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer all KMS keys in the Images account."
  default     = "AdministerKMSKeys"
}

variable "ami_build_cidr" {
  type        = string
  description = "The CIDR block to assign to the VPC and subnet used to build AMIs."
  default     = "192.168.100.0/24"
}

variable "ami_kms_key_alias" {
  type        = string
  description = "The alias to assign to the KMS key used to encrypt AMIs in the Images account."
  default     = "cool-amis"
}

variable "ami_kms_key_description" {
  type        = string
  description = "The description to assign to the KMS key used to encrypt AMIs in the Images account."
  default     = "The key used to encrypt AMIs in this account."
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for the Images account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "ec2amicreate_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account."
  default     = "Allows sufficient permissions to create AMIs in the Images account."
}

variable "ec2amicreate_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account."
  default     = "EC2AMICreate"
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Images account."
  default     = "Allows sufficient permissions to provision all AWS resources in the Images account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Images account."
  default     = "ProvisionAccount"
}

variable "provisionec2amicreateroles_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can create AMIs in the Images account."
  default     = "Allows creation of IAM roles that can create AMIs in the Images account."
}

variable "provisionec2amicreateroles_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can create AMIs in the Images account."
  default     = "ProvisionEC2AMICreateRoles"
}

variable "provisionkmskeys_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision KMS keys in the Images account."
  default     = "Allows sufficient permissions to provision KMS keys in the Images account."
}

variable "provisionkmskeys_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision KMS keys in the Images account."
  default     = "ProvisionKMSKeys"
}

variable "provisionthirdpartybucket_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account."
  default     = "Allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account."
}

variable "provisionthirdpartybucket_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account."
  default     = "ProvisionThirdPartyBucket"
}

variable "provisionthirdpartybucketreadroles_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can read objects in the third-party file storage S3 bucket in the Images account."
  default     = "Allows creation of IAM roles that can read objects in the third-party file storage S3 bucket in the Images account."
}

variable "provisionthirdpartybucketreadroles_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can read objects in the third-party file storage S3 bucket in the Images account."
  default     = "ProvisionThirdPartyBucketReadRoles"
}

variable "provisionvpcs_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision VPCs (and related resources) in the Images account."
  default     = "Allows sufficient permissions to provision VPCs (and related resources) in the Images account."
}

variable "provisionvpcs_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows sufficient permissions to provision VPCs (and related resources) in the Images account."
  default     = "ProvisionVPCs"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}

variable "third_party_bucket_name_prefix" {
  type        = string
  description = "The prefix to use to name the S3 bucket for storing third-party files.  The bucket will be named with this prefix plus the account type (e.g. production or staging)."
  default     = "cisa-cool-third-party"
}
