# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

# This bucket is created by cisagov/findings-data-import-terraform.
variable "assessment_findings_bucket_name" {
  description = "The name of the assessment findings S3 bucket."
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
  type        = string
}

variable "assessment_findings_bucket_write_role_description" {
  default     = "Allows write permissions to the assessment findings S3 bucket."
  description = "The description to associate with the IAM role that allows write access to the assessment findings S3 bucket."
  type        = string
}

variable "assessment_findings_bucket_write_role_name" {
  default     = "AssessmentFindingsBucketWrite"
  description = "The name to assign the IAM role that allows write access to the assessment findings S3 bucket."
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources for the Shared Services account are to be provisioned (e.g. \"us-east-1\")."
  type        = string
}

variable "provisionaccount_role_description" {
  default     = "Allows sufficient permissions to provision all AWS resources in the Shared Services account."
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  type        = string
}

variable "provisionssmsessionmanager_policy_description" {
  default     = "Allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  type        = string
}

variable "provisionssmsessionmanager_policy_name" {
  default     = "ProvisionSSMSessionManager"
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the SSM Document resource and set up SSM session logging in the Shared Services account."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}
