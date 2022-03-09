# ------------------------------------------------------------------------------
# Create the SNS topic that allows email to be sent for CloudWatch
# alarms.  Subscribe the account email to the new SNS topic.
# ------------------------------------------------------------------------------

module "cw_alarm_sns" {
  providers = {
    aws                         = aws
    aws.organizations_read_only = aws.organizationsreadonly
  }
  source = "github.com/cisagov/cw-alarm-sns-tf-module"
}
