# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "admin_usernames" {
  type        = list(string)
  description = "The usernames associated with the admin accounts to be created, which are allowed to access the terraform backend and are IAM administrators.  The format first.last is recommended."
}

variable "terraform_account_id" {
  description = "The ID of the Terraform account, which contains roles that can be assumed to access the Terraform backend and to provision AWS resouces in that account."
}

variable "this_account_id" {
  description = "The ID of the account being configured."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

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

variable "assume_tf_provisionaccount_policy_description" {
  description = "The description to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the Terraform account."
  default     = "Allow assumption of the ProvisionAccount role in the Terraform account."
}

variable "assume_tf_provisionaccount_policy_name" {
  description = "The name to associate with the IAM policy that allows assumption of the role with sufficient permissions to provision all AWS resources in the Terraform account."
  default     = "Terraform-AssumeProvisionAccount"
}

variable "aws_region" {
  description = "The AWS region where the non-global resources for this account are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "iam_admin_role_description" {
  description = "The description to associate with the IAM role that allows full IAM administrator access in this account."
  default     = "Allows full IAM administrator access in this account."
}

variable "iam_admin_role_name" {
  description = "The name to assign the IAM role that allows full IAM administrator access in this account."
  default     = "IamAdministrator"
}

variable "iam_admins_group_name" {
  description = "The name of the group to be created for users allowed to be IAM administrators."
  default     = "iam_admins"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources provisioned."
  default     = {}
}

variable "terraform_account_provisioners_group_name" {
  description = "The name of the group to be created for users allowed to provision the Terraform account."
  default     = "terraform_account_provisioners"
}

variable "terraform_backend_users_group_name" {
  description = "The name of the group to be created for users allowed to access the Terraform backend."
  default     = "terraform_backend_users"
}
