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

variable "state_bucket_name" {
  description = "The name to use for the S3 bucket that will store the Terraform state."
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "access_domainmanager_terraform_backend_role_description" {
  default     = "Allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  type        = string
}

variable "access_domainmanager_terraform_backend_role_name" {
  default     = "AccessDomainManagerTerraformBackend"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  type        = string
}

variable "access_pca_terraform_backend_role_description" {
  default     = "Allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  type        = string
}

variable "access_pca_terraform_backend_role_name" {
  default     = "AccessPCATerraformBackend"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  type        = string
}

variable "access_terraform_backend_role_description" {
  default     = "Allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  type        = string
}

variable "access_terraform_backend_role_name" {
  default     = "AccessTerraformBackend"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region where the non-global resources for this account are to be provisioned (e.g. \"us-east-1\")."
  type        = string
}

variable "domainmanager_terraform_projects" {
  default     = []
  description = "The list of project names that contain Domain Manager-related Terraform code (e.g. [\"my-domain-manager-project\"])."
  type        = list(string)
}

variable "pca_terraform_projects" {
  default     = []
  description = "The list of project names that contain PCA-related Terraform code (e.g. [\"my-pca-project\"])."
  type        = list(string)
}

variable "provisionaccount_role_description" {
  default     = "Allows sufficient permissions to provision all AWS resources in the Terraform account."
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account."
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account."
  type        = string
}

variable "provisionbackend_policy_description" {
  default     = "Allows sufficient permissions to provision the Terraform backend resources in the Terraform account."
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the Terraform backend resources in the Terraform account."
  type        = string
}

variable "provisionbackend_policy_name" {
  default     = "ProvisionBackend"
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the Terraform backend resources in the Terraform account."
  type        = string
}

variable "read_terraform_state_role_description" {
  default     = "Allows read-only access to the S3 bucket where Terraform state is stored."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored."
  type        = string
}

variable "read_terraform_state_role_name" {
  default     = "ReadTerraformState"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored."
  type        = string
}

variable "state_table_name" {
  default     = "terraform-state-lock"
  description = "The name to use for the DynamoDB table that will be used for Terraform state locking."
  type        = string
}

variable "state_table_read_capacity" {
  default     = 20
  description = "The number of read units for the DynamoDB table that will be used for Terraform state locking."
  type        = number
}

variable "state_table_write_capacity" {
  default     = 20
  description = "The number of write units for the DynamoDB table that will be used for Terraform state locking."
  type        = number
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  type        = map(string)
}
