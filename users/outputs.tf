output "iam_admin_role_arn" {
  value       = aws_iam_role.iam_admin_role.arn
  description = "The ARN of the IAM role that allows full IAM administrator access in this account."
}
