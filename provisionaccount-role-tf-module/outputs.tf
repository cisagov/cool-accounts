output "account_provisioners_group_arn" {
  value       = aws_iam_group.account_provisioners.arn
  description = "The ARN of the IAM group that is allowed sufficient permissions to provision all AWS resources in the new account."
}

output "provisionaccount_role_arn" {
  value       = aws_iam_role.provisionaccount_role.arn
  description = "The ARN of the IAM role that allows sufficient permissions to provision all AWS resources in the new account."
}
