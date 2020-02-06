output "certificate_bucket_arn" {
  value       = aws_s3_bucket.certificate_bucket.arn
  description = "The ARN of the S3 bucket where Certboto certificates will be stored."
}

output "certificate_bucket_id" {
  value       = aws_s3_bucket.certificate_bucket.id
  description = "The ID of the S3 bucket where Certboto certificates will be stored."
}

output "provisionaccount_role_arn" {
  value       = aws_iam_role.provisionaccount_role.arn
  description = "The ARN of the IAM role that allows sufficient permissions to provision all AWS resources in this account."
}
