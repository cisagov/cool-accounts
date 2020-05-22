output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
}

output "ssmsession_role" {
  value       = aws_iam_role.ssmsession_role
  description = "The IAM role that allows creation of SSM SessionManager sessions to any EC2 instance in this account."
}
