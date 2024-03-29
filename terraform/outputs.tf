output "access_domainmanager_terraform_backend_role" {
  value       = aws_iam_role.access_domainmanager_terraform_backend_role
  description = "The IAM role that allows sufficient access to the the Domain Manager-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

output "access_pca_terraform_backend_role" {
  value       = aws_iam_role.access_pca_terraform_backend_role
  description = "The IAM role that allows sufficient access to the the PCA-related items in the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

output "access_terraform_backend_role" {
  value       = aws_iam_role.access_terraform_backend_role
  description = "The IAM role that allows sufficient access to the Terraform S3 bucket and DynamoDB table to use those resources as a Terraform backend."
}

output "cw_alarm_sns_topic" {
  value       = module.cw_alarm_sns.sns_topic
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Terraform account."
}

output "read_terraform_state_role" {
  value       = aws_iam_role.read_terraform_state_role
  description = "The IAM role that allows read-only access to the S3 bucket where Terraform state is stored."
}

output "state_bucket" {
  value       = aws_s3_bucket.state_bucket
  description = "The S3 bucket where Terraform state information will be stored."
}

output "state_lock_table" {
  value       = aws_dynamodb_table.state_lock_table
  description = "The DynamoDB table that to be used for Terraform state locking."
}
