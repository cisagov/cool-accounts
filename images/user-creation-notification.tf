# ------------------------------------------------------------------------------
# Create the SNS topic that allows email to be sent when a new IAM or
# SSO user is created.  Subscribe the account email to the new SNS
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
      # We can't use module.new_user_sns.sns_topic.arn here because it
      # creates a cycle; fortunately, we can create the SNS topic ARN
      # manually.
      "arn:aws:sns:${var.aws_region}:${data.aws_caller_identity.this.account_id}:new-user-created",
    ]
  }
}

module "new_user_sns" {
  providers = {
    aws                         = aws
    aws.organizations_read_only = aws.organizationsreadonly
  }
  source = "github.com/cisagov/sns-send-to-account-email-tf-module"

  topic_access_policy = data.aws_iam_policy_document.sns_topic_access_policy_doc.json
  topic_display_name  = "New IAM or SSO user created"
  topic_name          = "new-user-created"
}

# ------------------------------------------------------------------------------
# Create the EventBridge event rule that is triggered whenever a new
# IAM or SSO user is created.  Connect this rule to the SNS topic
# created above.
# ------------------------------------------------------------------------------

module "new_user_event" {
  providers = {
    aws = aws
  }
  source = "github.com/cisagov/new-user-alert-tf-module"

  target_arn = module.new_user_sns.sns_topic.arn
}
