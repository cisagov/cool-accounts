# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "state_bucket_name" {
  type        = string
  description = "The name to use for the S3 bucket that will store the Terraform state."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "access_domainmanager_terraform_backend_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "Allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

variable "access_domainmanager_terraform_backend_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "AccessDomainManagerTerraformBackend"
}

variable "access_pca_terraform_backend_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "Allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

variable "access_pca_terraform_backend_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "AccessPCATerraformBackend"
}

variable "access_terraform_backend_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "Allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

variable "access_terraform_backend_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  default     = "AccessTerraformBackend"
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources for this account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "domainmanager_terraform_projects" {
  type        = list(string)
  description = "The list of project names that contain Domain Manager-related Terraform code (e.g. [\"my-domain-manager-project\"])."
  default     = []
}

variable "pca_terraform_projects" {
  type        = list(string)
  description = "The list of project names that contain PCA-related Terraform code (e.g. [\"my-pca-project\"])."
  default     = []
}

variable "provisionaccount_role_description" {
  type        = string
  description = "The description to associate with the IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account."
  default     = "Allows sufficient permissions to provision all AWS resources in the Terraform account."
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name to assign the IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account."
  default     = "ProvisionAccount"
}

variable "provisionbackend_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the Terraform backend resources in the Terraform account."
  default     = "Allows sufficient permissions to provision the Terraform backend resources in the Terraform account."
}

variable "provisionbackend_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the Terraform backend resources in the Terraform account."
  default     = "ProvisionBackend"
}

variable "read_terraform_state_role_description" {
  type        = string
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored."
  default     = "Allows read-only access to the S3 bucket where Terraform state is stored."
}

variable "read_terraform_state_role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the S3 bucket where Terraform state is stored."
  default     = "ReadTerraformState"
}

variable "state_table_name" {
  type        = string
  description = "The name to use for the DynamoDB table that will be used for Terraform state locking."
  default     = "terraform-state-lock"
}

variable "state_table_read_capacity" {
  type        = number
  description = "The number of read units for the DynamoDB table that will be used for Terraform state locking."
  default     = 20
}

variable "state_table_write_capacity" {
  type        = number
  description = "The number of write units for the DynamoDB table that will be used for Terraform state locking."
  default     = 20
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
