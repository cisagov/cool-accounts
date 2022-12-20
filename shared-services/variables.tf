# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

# This bucket is created by cisagov/findings-data-import-terraform.
variable "assessment_findings_bucket_arn" {
  type        = string
  description = "The ARN of the assessment findings S3 bucket."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "assessment_findings_bucket_object_name_pattern" {
  type        = string
  description = "The name pattern specifying which objects are allowed to be written to the assessment findings data S3 bucket."
  default     = "*-data.json"
}

variable "assessment_findings_bucket_write_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows write access to the assessment findings S3 bucket."
  default     = "Allows write permissions to the assessment findings S3 bucket."
}

variable "assessment_findings_bucket_write_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows write access to the assessment findings S3 bucket."
  default     = "AssessmentFindingsBucketWrite"
}

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

variable "provisionssmsessionmanager_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  default     = "Allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
}

variable "provisionssmsessionmanager_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  default     = "ProvisionSSMSessionManager"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
