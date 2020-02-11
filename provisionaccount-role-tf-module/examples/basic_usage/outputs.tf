output "account_provisioners_group_arn" {
  value       = module.provisionaccount.account_provisioners_group_arn
  description = "The ARN of the IAM group that is allowed sufficient permissions to provision all AWS resources in the Pettifogger0 account."
}

output "provisionaccount_role_arn" {
  value       = module.provisionaccount.provisionaccount_role_arn
  description = "The ARN of the IAM role that allows sufficient permissions to provision all AWS resources in the Pettifogger0 account."
}