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
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources for the DNS account are to be provisioned (e.g. \"us-east-1\")."
  nullable    = false
  type        = string
}

variable "provisionaccount_role_description" {
  default     = "Allows sufficient permissions to provision all AWS resources in the DNS account."
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the DNS account."
  nullable    = false
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the DNS account."
  nullable    = false
  type        = string
}

variable "provisionpublishegressip_role_description" {
  default     = "Allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
  nullable    = false
  type        = string
}

variable "provisionpublishegressip_role_name" {
  default     = "ProvisionPublishEgressIP"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
  nullable    = false
  type        = string
}

variable "provisionroute53_role_description" {
  default     = "Allows sufficient permissions to provision Route 53 in the DNS account."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision Route 53 in the DNS account."
  nullable    = false
  type        = string
}

variable "provisionroute53_role_name" {
  default     = "ProvisionRoute53"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient permissions to provision Route 53 in the DNS account."
  nullable    = false
  type        = string
}

variable "publishegressip_lambda_name" {
  default     = "publish-egress-ip"
  description = "The name of the Lambda function used in cisagov/publish-egress-ip-terraform.  This name is used to specify resource constraints in the role/policy specified in var.provisionpublishegressip_role_name."
  nullable    = false
  type        = string
}

variable "publishegressip_role_name" {
  default     = "PublishEgressIPLambda"
  description = "The name of the IAM role (meant to be used in cisagov/publish-egress-ip-terraform) that is allowed to be created by the role/policy specified in var.provisionpublishegressip_role_name."
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
