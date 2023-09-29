# ------------------------------------------------------------------------------
# Create the SNS topic that allows email to be sent for CloudWatch
# alarms.  Subscribe the account email to the new SNS topic.
# ------------------------------------------------------------------------------

module "cw_alarm_sns" {
  providers = {
    aws                         = aws
    aws.organizations_read_only = aws.organizationsreadonly
  }
  source = "github.com/cisagov/sns-send-to-account-email-tf-module"

  topic_display_name = "cloudwatch_alarms"
  topic_name         = "cloudwatch-alarms"
}
