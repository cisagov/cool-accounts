output "access_terraform_backend_role_arn" {
  value       = aws_iam_role.access_terraform_backend_role.arn
  description = "The ARN of the IAM role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

output "provisionaccount_role_arn" {
  value       = aws_iam_role.provisionaccount_role.arn
  description = "The ARN of the IAM role that allows sufficient permissions to provision all AWS resources in this account."
}

output "state_bucket_arn" {
  value       = aws_s3_bucket.state_bucket.arn
  description = "The ARN of the S3 bucket where Terraform state information will be stored."
}

output "state_bucket_id" {
  value       = aws_s3_bucket.state_bucket.id
  description = "The ID of the S3 bucket where Terraform state information will be stored."
}

output "state_lock_table_arn" {
  value       = aws_dynamodb_table.state_lock_table.arn
  description = "The ARN of the DynamoDB table that to be used for Terraform state locking."
}

output "state_lock_table_id" {
  value       = aws_dynamodb_table.state_lock_table.id
  description = "The ID of the DynamoDB table that to be used for Terraform state locking."
}
