output "administerkmskeys_role" {
  description = "The IAM role that allows sufficient permissions to administer KMS keys in the Images account."
  value       = aws_iam_role.administerkmskeys_role
}

output "ami_kms_key" {
  description = "The KMS key for encrypting AMIs in the Images account."
  value       = aws_kms_key.amis
}

output "cw_alarm_sns_topic" {
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
  value       = module.cw_alarm_sns.sns_topic
}

output "ec2amicreate_role" {
  description = "The IAM role that allows sufficient permissions to create AMIs in the Images account."
  value       = aws_iam_role.ec2amicreate_role
}

output "provisionaccount_role" {
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Images account."
  value       = module.provisionaccount.provisionaccount_role
}

output "provisionec2amicreateroles_role" {
  description = "The IAM role that allows sufficient permissions to provision IAM roles that can create AMIs in the Images account."
  value       = aws_iam_role.provisionec2amicreateroles_role
}

output "provisionthirdpartybucketreadroles_role" {
  description = "The IAM role that allows sufficient permissions to provision IAM roles that can read objects in the third-party file storage S3 bucket in the Images account."
  value       = aws_iam_role.provisionthirdpartybucketreadroles
}

output "third_party_bucket" {
  description = "The S3 bucket for storing third-party files."
  value       = aws_s3_bucket.third_party
}

output "wiz_connector_arn" {
  description = "The ARN of the IAM role created for the Wiz AWS connector."
  value       = module.wiz.role_arn
}
