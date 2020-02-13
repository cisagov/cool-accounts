output "assume_any_role_anywhere_policy_arn" {
  value       = aws_iam_policy.assume_any_role_anywhere.arn
  description = "The ARN of the IAM role that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
}

output "godlike_users" {
  value       = { for username, user in aws_iam_user.gods : username => user.arn }
  description = "A map whose keys are the usernames of, and whose values are the ARNs of, the IAM users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
}

output "gods_group_arn" {
  value       = aws_iam_group.gods.arn
  description = "The ARN of the IAM group containing the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
}

output "provisionaccount_role_arn" {
  value       = aws_iam_role.provisionaccount_role.arn
  description = "The ARN of the IAM role that allows sufficient permissions to provision all AWS resources in this account."
}
