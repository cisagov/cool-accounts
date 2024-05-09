output "cw_alarm_sns_topic" {
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
  value       = module.cw_alarm_sns.sns_topic
}

output "ec2readonly_role" {
  description = "The IAM role that allows read access to some EC2 attributes in the dynamic account."
  value       = aws_iam_role.ec2readonly_role
}

output "provisionaccount_role" {
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the dynamic account."
  value       = module.provisionaccount.provisionaccount_role
}
