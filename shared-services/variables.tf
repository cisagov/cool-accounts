# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

# This bucket is created by cisagov/findings-data-import-terraform.
variable "assessment_findings_bucket_name" {
  description = "The name of the assessment findings S3 bucket."
  nullable    = false
  type        = string
}

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

variable "assessment_findings_bucket_object_key_pattern" {
  default     = "*-data.json"
  description = "The key pattern specifying which objects are allowed to be written to the assessment findings data S3 bucket."
  nullable    = false
  type        = string
}

variable "assessment_findings_bucket_write_role_description" {
  default     = "Allows write permissions to the assessment findings S3 bucket."
  description = "The description to associate with the IAM role that allows write access to the assessment findings S3 bucket."
  nullable    = false
  type        = string
}

variable "assessment_findings_bucket_write_role_name" {
  default     = "AssessmentFindingsBucketWrite"
  description = "The name to assign the IAM role that allows write access to the assessment findings S3 bucket."
  nullable    = false
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources for the Shared Services account are to be provisioned (e.g. \"us-east-1\")."
  nullable    = false
  type        = string
}

variable "ebs_volume_snapshot_create_interval" {
  default     = 1
  description = "A positive, non-zero integer denoting the interval in days at which new snapshots of EBS volumes are to be created (e.g., 5).  Valid values range from 1 to 7."
  nullable    = false
  type        = number

  validation {
    # floor() verifies the number is an integer.
    condition     = floor(var.ebs_volume_snapshot_create_interval) == var.ebs_volume_snapshot_create_interval && var.ebs_volume_snapshot_create_interval >= 1 && var.ebs_volume_snapshot_create_interval <= 7
    error_message = "The creation interval must be a positive, non-zero integer in the range [1,7]."
  }
}

variable "ebs_volume_snapshot_retain_interval" {
  default     = 14
  description = "A positive, non-zero integer denoting the number of days that new snapshots of EBS volumes are to be retained (e.g., 5).  Valid values range from 2 to 14."
  nullable    = false
  type        = number

  validation {
    # floor() verifies the number is an integer.
    condition     = floor(var.ebs_volume_snapshot_retain_interval) == var.ebs_volume_snapshot_retain_interval && var.ebs_volume_snapshot_retain_interval >= 2 && var.ebs_volume_snapshot_retain_interval <= 14
    error_message = "The retention interval must be a positive, non-zero integer in the range [2,14]."
  }
}

variable "provisionaccount_role_description" {
  default     = "Allows sufficient permissions to provision all AWS resources in the Shared Services account."
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  nullable    = false
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  nullable    = false
  type        = string
}

variable "provisionssmsessionmanager_policy_description" {
  default     = "Allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  nullable    = false
  type        = string
}

variable "provisionssmsessionmanager_policy_name" {
  default     = "ProvisionSSMSessionManager"
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
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
