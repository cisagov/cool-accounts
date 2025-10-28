output "cw_alarm_sns_topic" {
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
  value       = module.cw_alarm_sns.sns_topic
}

output "provisionaccount_role" {
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Audit account."
  value       = module.provisionaccount.provisionaccount_role
}

output "wiz_connector_arn" {
  description = "The ARN of the IAM role created for the Wiz AWS connector."
  value       = module.wiz.role_arn
}
