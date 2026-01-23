# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "lambda_bucket_name" {
  description = "The name of the bucket where Lambda deployment packages are to be stored."
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

variable "administersso_role_description" {
  default     = "Allows sufficient permissions to administer the Single Sign-On resources in the Master account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer the Single Sign-On resources in the Master account."
  nullable    = false
  type        = string
}

variable "administersso_role_name" {
  default     = "AdministerSSO"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer the Single Sign-On resources in the Master account."
  nullable    = false
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources for the Master account are to be provisioned (e.g. \"us-east-1\")."
  nullable    = false
  type        = string
}

variable "controltoweradmin_role_description" {
  default     = "Allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
  description = "The description to associate with the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
  nullable    = false
  type        = string
}

variable "controltoweradmin_role_name" {
  default     = "ControlTowerAdmin"
  description = "The name to assign the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
  nullable    = false
  type        = string
}

variable "cur_export_policy_description" {
  default     = "Allows sufficient permissions to create the resources needed for cost and usage report (CUR) data export."
  description = "The description to associate with the IAM policy that allows sufficient permissions to manage the resources needed for cost and usage report (CUR) data export."
  nullable    = false
  type        = string
}

variable "cur_export_policy_name" {
  default     = "CostAndUsageReportExportPolicy"
  description = "The name to assign the IAM policy that allows sufficient permissions to manage the resources needed for cost and usage report (CUR) data export."
  nullable    = false
  type        = string
}

variable "organizationsreadonly_role_description" {
  default     = "Allows read-only access to all AWS Organizations information in the Master account."
  description = "The description to associate with the IAM role that allows read-only access to all AWS Organizations information in the Master account."
  nullable    = false
  type        = string
}

variable "organizationsreadonly_role_name" {
  default     = "OrganizationsReadOnly"
  description = "The name to assign the IAM role that allows read-only access to all AWS Organizations information in the Master account."
  nullable    = false
  type        = string
}

variable "provisionaccount_role_description" {
  default     = "Allows sufficient permissions to provision all AWS resources in the Master account."
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Master account."
  nullable    = false
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Master account."
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
