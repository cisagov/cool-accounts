output "cw_alarm_sns_topic" {
  description = "The SNS topic to which a message is sent when a CloudWatch alarm is triggered."
  value       = module.cw_alarm_sns.sns_topic
}

output "primary_delegation_set" {
  description = "The primary reusable delegation set that contains the authoritative name servers for all public DNS zones."
  value       = aws_route53_delegation_set.primary
}

output "provisionaccount_role" {
  description = "The IAM role that allows sufficient permissions to provision all AWS resources in the DNS account."
  value       = module.provisionaccount.provisionaccount_role
}

output "provisionpublishegressip_role" {
  description = "The IAM role that allows sufficient permissions to provision all resources related to the publish-egress-ip Lambda in the DNS account."
  value       = aws_iam_role.provisionpublishegressip_role
}
