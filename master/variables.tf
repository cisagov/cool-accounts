# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "lambda_bucket_name" {
  description = "The name of the bucket where Lambda zip files are to be stored."
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
  type        = string
}

variable "administersso_role_name" {
  default     = "AdministerSSO"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer the Single Sign-On resources in the Master account."
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources for the Master account are to be provisioned (e.g. \"us-east-1\")."
  type        = string
}

variable "controltoweradmin_role_description" {
  default     = "Allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
  description = "The description to associate with the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
  type        = string
}

variable "controltoweradmin_role_name" {
  default     = "ControlTowerAdmin"
  description = "The name to assign the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
  type        = string
}

variable "organizationsreadonly_role_description" {
  default     = "Allows read-only access to all AWS Organizations information in the Master account."
  description = "The description to associate with the IAM role that allows read-only access to all AWS Organizations information in the Master account."
  type        = string
}

variable "organizationsreadonly_role_name" {
  default     = "OrganizationsReadOnly"
  description = "The name to assign the IAM role that allows read-only access to all AWS Organizations information in the Master account."
  type        = string
}

variable "provisionaccount_role_description" {
  default     = "Allows sufficient permissions to provision all AWS resources in the Master account."
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Master account."
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Master account."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}

variable "write_lambda_bucket_role_description" {
  default     = "Allows sufficient permissions to write to the bucket that contains Lambda zip files in the Master account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to write to the bucket that contains Lambda zip files in the Master account."
  type        = string
}

variable "write_lambda_bucket_role_name" {
  default     = "WriteLambdaBucket"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to write to the bucket that contains Lambda zip files in the Master account."
  type        = string
}
