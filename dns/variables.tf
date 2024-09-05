# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "lambda_bucket_name" {
  description = "The name of the S3 bucket containing the Lambda function deployment package to disable inactive IAM users."
  type        = string
}

variable "lambda_key" {
  description = "The S3 key associated with the Lambda function deployment package to disable inactive IAM users."
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources for the DNS account are to be provisioned (e.g. \"us-east-1\")."
  type        = string
}

variable "provisionaccount_role_description" {
  default     = "Allows sufficient permissions to provision all AWS resources in the DNS account."
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the DNS account."
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the DNS account."
  type        = string
}

variable "provisionpublishegressip_role_description" {
  default     = "Allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
  type        = string
}

variable "provisionpublishegressip_role_name" {
  default     = "ProvisionPublishEgressIP"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
  type        = string
}

variable "provisionroute53_role_description" {
  default     = "Allows sufficient permissions to provision Route 53 in the DNS account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision Route 53 in the DNS account."
  type        = string
}

variable "provisionroute53_role_name" {
  default     = "ProvisionRoute53"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision Route 53 in the DNS account."
  type        = string
}

variable "publishegressip_lambda_name" {
  default     = "publish-egress-ip"
  description = "The name of the Lambda function used in cisagov/publish-egress-ip-terraform.  This name is used to specify resource constraints in the role/policy specified in var.provisionpublishegressip_role_name."
  type        = string
}

variable "publishegressip_role_name" {
  default     = "PublishEgressIPLambda"
  description = "The name of the IAM role (meant to be used in cisagov/publish-egress-ip-terraform) that is allowed to be created by the role/policy specified in var.provisionpublishegressip_role_name."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}
