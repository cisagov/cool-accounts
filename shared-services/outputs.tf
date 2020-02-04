output "provision_account_role_arn" {
  value       = aws_iam_role.provision_account_role.arn
  description = "The ARN of the IAM role that allows sufficient permissions to provision all AWS resources in this account."
}
