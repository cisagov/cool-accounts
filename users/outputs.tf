output "assume_any_role_anywhere_policy" {
  value       = aws_iam_policy.assume_any_role_anywhere
  description = "The IAM role that allows assumption of any role in any account, so long as it has a trust relationship with the Users account."
}

output "godlike_users" {
  value       = aws_iam_user.gods
  description = "The IAM users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
}

output "gods_group" {
  value       = aws_iam_group.gods
  description = "The IAM group containing the god-like users that are allowed to access the terraform backend, are IAM administrators for the Users account, and are allowed to assume any role that has a trust relationship with the Users account."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in this account."
}
