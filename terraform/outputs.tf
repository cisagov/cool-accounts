output "access_terraform_backend_role" {
  description = "The IAM role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
  value       = aws_iam_role.access_terraform_backend_role
}

output "cw_alarm_sns_topic" {
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
  value       = module.cw_alarm_sns.sns_topic
}

output "provisionaccount_role" {
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account."
  value       = module.provisionaccount.provisionaccount_role
}

output "read_terraform_state_role" {
  description = "The IAM role that allows read-only access to the S3 bucket where Terraform state is stored."
  value       = aws_iam_role.read_terraform_state_role
}

output "state_bucket" {
  description = "The S3 bucket where Terraform state information will be stored."
  value       = aws_s3_bucket.state_bucket
}

output "state_lock_table" {
  description = "The DynamoDB table that to be used for Terraform state locking."
  value       = aws_dynamodb_table.state_lock_table
}

output "wiz_connector_arn" {
  description = "The ARN of the IAM role created for the Wiz AWS connector."
  value       = module.wiz.role_arn
}
