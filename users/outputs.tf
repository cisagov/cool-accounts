output "assume_any_role_anywhere_policy" {
  description = "The IAM role that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
  value       = aws_iam_policy.assume_any_role_anywhere
}

output "cw_alarm_sns_topic" {
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
  value       = module.cw_alarm_sns.sns_topic
}

output "godlike_users" {
  description = "The IAM users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
  value       = aws_iam_user.gods
}

output "gods_group" {
  description = "The IAM group containing the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
  value       = aws_iam_group.gods
}

output "provisionaccount_role" {
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in this account."
  value       = module.provisionaccount.provisionaccount_role
}

output "selfmanagedcredswithmfa_policy" {
  description = "The IAM policy that allows users to administer their own user accounts, requiring multi-factor authentication (MFA)."
  value       = aws_iam_policy.self_managed_creds_with_mfa
}

output "selfmanagedcredswithoutmfa_policy" {
  description = "The IAM policy that allows users to administer their own user accounts, without requiring multi-factor authentication (MFA)."
  value       = aws_iam_policy.self_managed_creds_without_mfa
}
