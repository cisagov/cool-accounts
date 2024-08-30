# ------------------------------------------------------------------------------
# Create the EventBridge event rule that triggers at a fixed cadence,
# kicking off a Lambda function that disables inactive IAM users.
# ------------------------------------------------------------------------------
module "disable-inactive-iam-users" {
  providers = {
    aws = aws
  }

  source = "github.com/cisagov/disable-inactive-iam-users-tf-module?ref=first-commits"
}
