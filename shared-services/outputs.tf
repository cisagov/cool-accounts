output "assessment_findings_write_role" {
  value       = aws_iam_role.assessment_findings_bucket_write
  description = "The IAM role that allows write access to the assessment findings S3 bucket."
}

output "cw_alarm_sns_topic" {
  value       = module.cw_alarm_sns.sns_topic
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
}

output "provisionaccount_role" {
  value       = module.provisionaccount.provisionaccount_role
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
}

output "ssm_session_role" {
  value       = module.session_manager.ssm_session_role
  description = "The IAM role that allows creation of SSM Session Manager sessions to any EC2 instance in this account."
}
