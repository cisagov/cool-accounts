# ------------------------------------------------------------------------------
# Create the SNS topic that allows email to be sent whenever a new IAM or SSO
# user is created or deleted, a user is added or removed from a group, or a
# group is created or deleted.  Subscribe the account email to the new SNS
# topic.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "sns_topic_access_policy_doc" {
  # Allow EventBridge to publish to the SNS topic.
  statement {
    actions = [
      "sns:Publish",
    ]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [
      # We can't use module.user_group_mod_sns.sns_topic.arn here because it
      # creates a cycle; fortunately, we can create the SNS topic ARN
      # manually.
      "arn:aws:sns:${var.aws_region}:${data.aws_caller_identity.this.account_id}:user-or-group-modified",
    ]
  }
}

module "user_group_mod_sns" {
  providers = {
    aws                         = aws
    aws.organizations_read_only = aws.organizationsreadonly
  }
  source = "github.com/cisagov/sns-send-to-account-email-tf-module"

  topic_access_policy = data.aws_iam_policy_document.sns_topic_access_policy_doc.json
  topic_display_name  = "IAM or SSO user or group modified"
  topic_name          = "user-or-group-modified"
}

# ------------------------------------------------------------------------------
# Create the EventBridge event rule that is triggered whenever a new IAM or SSO
# user is created or deleted, a user is added or removed from a group, or a
# group is created or deleted.  Connect this rule to the SNS topic created
# above.
# ------------------------------------------------------------------------------

module "user_group_mod_event" {
  providers = {
    aws = aws
  }
  source = "github.com/cisagov/user-group-mod-alert-tf-module"

  target_arn = module.user_group_mod_sns.sns_topic.arn
}
