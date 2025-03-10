# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "lambda_bucket_name" {
  description = "The name of the S3 bucket containing the Lambda function deployment package to disable inactive IAM users."
  nullable    = false
  type        = string
}

variable "lambda_key" {
  description = "The S3 key associated with the Lambda function deployment package to disable inactive IAM users."
  nullable    = false
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "administerkmskeys_role_description" {
  default     = "Allows sufficient permissions to administer all KMS keys in the Images account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer all KMS keys in the Images account."
  nullable    = false
  type        = string
}

variable "administerkmskeys_role_name" {
  default     = "AdministerKMSKeys"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer all KMS keys in the Images account."
  nullable    = false
  type        = string
}

variable "ami_build_cidr" {
  default     = "192.168.100.0/24"
  description = "The CIDR block to assign to the VPC and subnet used to build AMIs."
  nullable    = false
  type        = string
}

variable "ami_kms_key_alias" {
  default     = "cool-amis"
  description = "The alias to assign to the KMS key used to encrypt AMIs in the Images account."
  nullable    = false
  type        = string
}

variable "ami_kms_key_description" {
  default     = "The key used to encrypt AMIs in this account."
  description = "The description to assign to the KMS key used to encrypt AMIs in the Images account."
  nullable    = false
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources for the Images account are to be provisioned (e.g. \"us-east-1\")."
  nullable    = false
  type        = string
}

variable "ec2amicreate_role_description" {
  default     = "Allows sufficient permissions to create AMIs in the Images account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account."
  nullable    = false
  type        = string
}

variable "ec2amicreate_role_name" {
  default     = "EC2AMICreate"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to create AMIs in the Images account."
  nullable    = false
  type        = string
}

variable "extraorg_account_ids" {
  default     = []
  description = "A list of AWS account IDs corresponding to \"extra\" accounts that you want to allow to launch EC2 instances using one or more AMIs in this account (e.g. [\"123456789012\"]).  The ProvisionAccount role in these accounts will be allowed sufficient permissions to use the AMI encryption KMS key to launch instances.  Normally this variable is used to allow accounts that are not a member of the same AWS Organization as this account to use one or more AMIs from this account."
  nullable    = false
  type        = list(string)
}

variable "provisionaccount_role_description" {
  default     = "Allows sufficient permissions to provision all AWS resources in the Images account."
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Images account."
  nullable    = false
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Images account."
  nullable    = false
  type        = string
}

variable "provisionec2amicreateroles_role_description" {
  default     = "Allows creation of IAM roles that can create AMIs in the Images account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can create AMIs in the Images account."
  nullable    = false
  type        = string
}

variable "provisionec2amicreateroles_role_name" {
  default     = "ProvisionEC2AMICreateRoles"
  description = "The name to assign the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can create AMIs in the Images account."
  nullable    = false
  type        = string
}

variable "provisionkmskeys_role_description" {
  default     = "Allows sufficient permissions to provision KMS keys in the Images account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision KMS keys in the Images account."
  nullable    = false
  type        = string
}

variable "provisionkmskeys_role_name" {
  default     = "ProvisionKMSKeys"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision KMS keys in the Images account."
  nullable    = false
  type        = string
}

variable "provisionthirdpartybucket_policy_description" {
  default     = "Allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account."
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account."
  nullable    = false
  type        = string
}

variable "provisionthirdpartybucket_policy_name" {
  default     = "ProvisionThirdPartyBucket"
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the third-party file storage S3 bucket in the Images account."
  nullable    = false
  type        = string
}

variable "provisionthirdpartybucketreadroles_role_description" {
  default     = "Allows creation of IAM roles that can read objects in the third-party file storage S3 bucket in the Images account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can read objects in the third-party file storage S3 bucket in the Images account."
  nullable    = false
  type        = string
}

variable "provisionthirdpartybucketreadroles_role_name" {
  default     = "ProvisionThirdPartyBucketReadRoles"
  description = "The name to assign the IAM role (as well as the corresponding policy) with the ability to create IAM roles that can read objects in the third-party file storage S3 bucket in the Images account."
  nullable    = false
  type        = string
}

variable "provisionvpcs_policy_description" {
  default     = "Allows sufficient permissions to provision VPCs (and related resources) in the Images account."
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision VPCs (and related resources) in the Images account."
  nullable    = false
  type        = string
}

variable "provisionvpcs_policy_name" {
  default     = "ProvisionVPCs"
  description = "The name to assign the IAM policy that allows sufficient permissions to provision VPCs (and related resources) in the Images account."
  nullable    = false
  type        = string
}

variable "read_lambda_bucket_policy_description" {
  default     = "Allows read-only access to the bucket in the Terraform account containing Lambda deployments."
  description = "The description to associate with the IAM role that allows read-only access to the bucket in the Terraform account containing Lambda deployments."
  nullable    = false
  type        = string
}

variable "read_lambda_bucket_policy_name" {
  default     = "LambdaBucketReadOnly"
  description = "The name to assign the IAM policy that allows read-only access to the bucket in the Terraform account containing Lambda deployments."
  nullable    = false
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  nullable    = false
  type        = map(string)
}

variable "third_party_bucket_name_prefix" {
  default     = "cisa-cool-third-party"
  description = "The prefix to use to name the S3 bucket for storing third-party files.  The bucket will be named with this prefix plus the account type (e.g. production or staging)."
  nullable    = false
  type        = string
}

variable "third_party_bucket_parameter_name" {
  default     = "/third_party_bucket_name"
  description = "The name of the SSM Parameter Store parameter that will contain the name of the third-party S3 bucket, including the leading forward slash."
  nullable    = false
  type        = string

  validation {
    condition     = length(var.third_party_bucket_parameter_name) > 0 && substr(var.third_party_bucket_parameter_name, 0, 1) == "/"
    error_message = "The name of the SSM Parameter Store parameter must begin with a forward slash."
  }
}

variable "windows_ami_sg_name" {
  default     = "WindowsAMIBuild"
  description = "The name to associate with the security group that allows access for finalizing Windows AMI configuration."
  nullable    = false
  type        = string
}
