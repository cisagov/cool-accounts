output "administersso_role" {
  value       = aws_iam_role.administersso_role
  description = "The IAM role that allows sufficient permissions to administer the Single Sign-On resources required in the Master account."
}

output "controltoweradmin_role" {
  value       = aws_iam_role.controltoweradmin_role
  description = "The IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
}

output "organizationsreadonly_role" {
  value       = aws_iam_role.organizationsreadonly_role
  description = "The IAM role that allows read-only access to all AWS Organizations information in the Master account."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Master account."
}
