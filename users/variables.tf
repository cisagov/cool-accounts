# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "access_terraform_backend_role_arn" {
  type        = string
  description = "The ARN of the role that allows access to the Terraform backend."
}

variable "assume_access_terraform_backend_policy_description" {
  description = "The description to associate with the IAM policy that allows assumption of the role with access to the Terraform backend."
  default     = "Allow assumption of the AccessTerraformBackend role in the Terraform account."
}

variable "assume_access_terraform_backend_policy_name" {
  description = "The name to assign the IAM policy that allows assumption of the role with access to the Terraform backend."
  default     = "Terraform-AssumeAccessTerraformBackend"
}


variable "terraform_backend_users_group" {
  description = "The name of the group to be created for users allowed to access the terraform backend."
  default     = "terraform_backend_users"
}

variable "usernames" {
  type        = list(string)
  description = "The usernames associated with the accounts to be created and allowed to access the terraform backend, as well as be IAM administrators.  The format first.last is recommended."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}
