output "administersso_role" {
  description = "The IAM role that allows sufficient permissions to administer the Single Sign-On resources required in the Master account."
  value       = aws_iam_role.administersso_role
}

output "controltoweradmin_role" {
  description = "The IAM role that allows all necessary permissions to provision AWS accounts via Control Tower in the Master account."
  value       = aws_iam_role.controltoweradmin_role
}

output "cw_alarm_sns_topic" {
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
  value       = module.cw_alarm_sns.sns_topic
}

output "organizationsreadonly_role" {
  description = "The IAM role that allows read-only access to all AWS Organizations information in the Master account."
  value       = aws_iam_role.organizationsreadonly_role
}

output "provisionaccount_role" {
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the Master account."
  value       = module.provisionaccount.provisionaccount_role
}
