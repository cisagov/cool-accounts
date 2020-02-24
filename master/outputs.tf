output "organizationsreadonly_role" {
  value       = aws_iam_role.organizationsreadonly_role
  description = "The IAM role that allows read-only access to all AWS Organizations information in the Master account."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Master account."
}
