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

variable "wiz_external_id" {
  description = "The external ID of the Wiz AWS Connector.  This value must be retrieved from the Wiz portal when creating the AWS Connector."
  nullable    = false
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.wiz_external_id))
    error_message = "The external_id must match the pattern XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX (UUID format)."
  }
}

variable "wiz_remote_arn" {
  description = "The AWS Trust Policy Role ARN for your Wiz data center.  It can be retrieved from the Wiz portal (User Settings, Tenant)."
  nullable    = false
  type        = string
  validation {
    condition     = can(regex("^arn:aws:iam::[0-9]{12}:role/.*$", var.wiz_remote_arn))
    error_message = "The wiz_remote_arn must be a valid AWS IAM Role ARN (e.g., arn:aws:iam::123456789012:role/RoleName)."
  }
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
