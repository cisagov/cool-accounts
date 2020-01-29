output "bucket_id" {
  value       = aws_s3_bucket.the_bucket.id
  description = "The ID of the S3 bucket where Terraform state information will be stored."
}

output "bucket_arn" {
  value       = aws_s3_bucket.the_bucket.arn
  description = "The ARN of the S3 bucket where Terraform state information will be stored."
}

output "role_arn" {
  value       = aws_iam_role.the_role.arn
  description = "The ARN of the IAM role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

output "table_id" {
  value       = aws_dynamodb_table.the_table.id
  description = "The ID of the DynamoDB table that to be used for Terraform state locking."
}

output "table_arn" {
  value       = aws_dynamodb_table.the_table.arn
  description = "The ARN of the DynamoDB table that to be used for Terraform state locking."
}
