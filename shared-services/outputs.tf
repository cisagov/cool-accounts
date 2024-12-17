output "assessment_findings_write_role" {
  description = "The IAM role that allows write access to the assessment findings S3 bucket.  Note that this output will be null if there are no dynamic assessment accounts."
  value       = aws_iam_role.assessment_findings_bucket_write == [] ? null : aws_iam_role.assessment_findings_bucket_write[0]
}

output "cw_alarm_sns_topic" {
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
  value       = module.cw_alarm_sns.sns_topic
}

output "provisionaccount_role" {
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Shared Services account."
  value       = module.provisionaccount.provisionaccount_role
}

output "ssm_session_role" {
  description = "The IAM role that allows creation of SSM Session Manager sessions to any EC2 instance in this account."
  value       = module.session_manager.ssm_session_role
}
