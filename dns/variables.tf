# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for the DNS account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the DNS account."
  default     = "Allows sufficient permissions to provision all AWS resources in the DNS account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the DNS account."
  default     = "ProvisionAccount"
}

variable "provisionpublishegressip_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
  default     = "Allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
}

variable "provisionpublishegressip_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
  default     = "ProvisionPublishEgressIP"
}

variable "provisionroute53_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision Route 53 in the DNS account."
  default     = "Allows sufficient permissions to provision Route 53 in the DNS account."
}

variable "provisionroute53_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision Route 53 in the DNS account."
  default     = "ProvisionRoute53"
}

variable "publishegressip_lambda_name" {
  type        = string
  description = "The name of the Lambda function used in cisagov/publish-egress-ip-terraform.  This name is used to specify resource constraints in the role/policy specified in var.provisionpublishegressip_role_name."
  default     = "publish-egress-ip"
}

variable "publishegressip_role_name" {
  type        = string
  description = "The name of the IAM role (meant to be used in cisagov/publish-egress-ip-terraform) that is allowed to be created by the role/policy specified in var.provisionpublishegressip_role_name."
  default     = "PublishEgressIPLambda"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
