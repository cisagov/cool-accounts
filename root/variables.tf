# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "administersso_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer the Single Sign-On resources in the Root account."
  default     = "Allows sufficient permissions to administer the Single Sign-On resources in the Root account."
}

variable "administersso_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to administer the Single Sign-On resources in the Root account."
  default     = "AdministerSSO"
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for the Root account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "controltoweradmin_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Root account."
  default     = "Allows all necessary permissions to provision AWS accounts via Control Tower in the Root account."
}

variable "controltoweradmin_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Root account."
  default     = "ControlTowerAdmin"
}

variable "organizationsreadonly_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows read-only access to all AWS Organizations information in the Root account."
  default     = "Allows read-only access to all AWS Organizations information in the Root account."
}

variable "organizationsreadonly_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows read-only access to all AWS Organizations information in the Root account."
  default     = "OrganizationsReadOnly"
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Root account."
  default     = "Allows sufficient permissions to provision all AWS resources in the Root account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Root account."
  default     = "ProvisionAccount"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
