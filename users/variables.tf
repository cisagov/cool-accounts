# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "access_terraform_backend_role_arn" {
  type        = string
  description = "The ARN of the role that allows access to the Terraform backend."
}

variable "this_account_id" {
  description = "The ID of the account being configured."
}

variable "usernames" {
  type        = list(string)
  description = "The usernames associated with the accounts to be created and allowed to access the terraform backend, as well as become IAM administrators.  The format first.last is recommended."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region where the non-global resources for this account are to be created (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "assume_access_terraform_backend_policy_description" {
  description = "The description to associate with the IAM policy that allows assumption of the role with access to the Terraform backend."
  default     = "Allow assumption of the AccessTerraformBackend role in the Terraform account."
}

variable "assume_access_terraform_backend_policy_name" {
  description = "The name to assign the IAM policy that allows assumption of the role with access to the Terraform backend."
  default     = "Terraform-AssumeAccessTerraformBackend"
}

variable "assume_iam_admin_policy_description" {
  description = "The description to associate with the IAM policy that allows assumption of the role to become an IAM admininistrator."
  default     = "Allow assumption of the IamAdministrator role."
}

variable "assume_iam_admin_policy_name" {
  description = "The name to assign the IAM policy that allows assumption of the role to become an IAM admininistrator."
  default     = "AssumeIamAdministrator"
}

variable "iam_admin_role_description"  {
  description = "The description to associate with the IAM role that allows full IAM administrator access in this account."
  default     = "Allows full IAM administrator access in this account."
}

variable "iam_admin_role_name"  {
  description = "The name to assign the IAM role that allows full IAM administrator access in this account."
  default     = "IamAdministrator"
}

variable "iam_admins_group" {
  description = "The name of the group to be created for users allowed to be IAM administrators."
  default     = "iam_admins"
}

variable "terraform_backend_users_group" {
  description = "The name of the group to be created for users allowed to access the terraform backend."
  default     = "terraform_backend_users"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}
